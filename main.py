import mysql.connector
from PyQt5.QtWidgets import QApplication, QMainWindow, QWidget, QVBoxLayout, QLabel, QLineEdit, \
    QPushButton, QTableWidget, QTableWidgetItem
from decimal import Decimal

def calculateSemesterGpa(studentId, semester):
    conn = mysql.connector.connect(
        host='localhost',
        user='root',
        password='password',
        database='ProbationSystem'
    )
    cursor = conn.cursor()

    try:
        # Retrieve module details for the student in the given semester
        query = """
            SELECT 
                md.moduleCode, lg.gradeValue, mm.numOfCredits
            FROM 
                moduleDetails md
            INNER JOIN 
                letterGrades lg ON md.grade = lg.letterGrade
            INNER JOIN 
                moduleMaster mm ON md.moduleCode = mm.moduleCode
            WHERE 
                md.studentID = %s AND md.semester = %s
        """
        cursor.execute(query, (studentId, semester))
        modules = cursor.fetchall()

        totalGradePoints = 0
        totalCredits = 0

        for module in modules:
            gradeValue = module[1]
            credits = module[2]
            gradePointsEarned = gradeValue * credits
            totalGradePoints += gradePointsEarned
            totalCredits += credits

        if totalCredits == 0:
            return 0
        else:
            semesterGpa = totalGradePoints / totalCredits
            return semesterGpa

    except mysql.connector.Error as err:
        print("Error accessing database:", err)
        return None

    finally:
        cursor.close()
        conn.close()


def calculateCumulativeGpa(semester1Gpa, semester2Gpa):
    if semester1Gpa is None and semester2Gpa is None:
        return None
    elif semester1Gpa is None:
        return semester2Gpa
    elif semester2Gpa is None:
        return semester1Gpa

    totalGradePoints = semester1Gpa['totalGradePoints'] + semester2Gpa['totalGradePoints']
    totalCredits = semester1Gpa['totalCredits'] + semester2Gpa['totalCredits']

    if totalCredits == 0:
        return {'totalGradePoints': 0, 'totalCredits': 0}
    else:
        cumulativeGpa = totalGradePoints / totalCredits
        return {'totalGradePoints': totalGradePoints, 'totalCredits': totalCredits,
                'cumulativeGpa': cumulativeGpa}


def processStudentRecords(year, desiredGpa):
    conn = mysql.connector.connect(
        host='localhost',
        user='root',
        password='password',
        database='ProbationSystem'
    )
    cursor = conn.cursor(dictionary=True)

    try:
        query = """
            SELECT 
                md.studentID, 
                sm.studentFirstName, 
                sm.studentSurname,
                md.semester,
                SUM(lg.gradeValue * mm.numOfCredits) AS totalGradePoints,
                SUM(mm.numOfCredits) AS totalCredits,
                mm.numOfCredits
            FROM 
                moduleDetails md
            INNER JOIN 
                letterGrades lg ON md.grade = lg.letterGrade
            INNER JOIN 
                studentMaster sm ON md.studentID = sm.studentID
            INNER JOIN
                moduleMaster mm ON md.moduleCode = mm.moduleCode
            WHERE 
                md.moduleYear = %s
            GROUP BY 
                md.studentID, sm.studentFirstName, sm.studentSurname, md.semester, mm.numOfCredits
        """

        cursor.execute(query, (year,))
        studentRecords = cursor.fetchall()

        processedStudentIds = set()
        processedStudentRecords = []

        for record in studentRecords:
            studentId = record['studentID']
            studentName = f"{record['studentFirstName']} {record['studentSurname']}"
            totalCredits = record['totalCredits']

            # Calculate semester GPA
            semester1Gpa = calculateSemesterGpa(studentId, 1)
            semester2Gpa = calculateSemesterGpa(studentId, 2)

            # Calculate cumulative GPA
            cumulativeGpa = calculateCumulativeGpa(semester1Gpa, semester2Gpa)

            # Check if the student meets the desired GPA criteria
            if desiredGpa is None or (totalCredits != 0 and cumulativeGpa >= desiredGpa):

                # Print student information if not already processed
                if studentId not in processedStudentIds:
                    print(f"Student ID: {studentId}")
                    print(f"Student Name: {studentName}")
                    print(f"Semester 1 GPA: {semester1Gpa}")
                    print(f"Semester 2 GPA: {semester2Gpa}")
                    print(f"Cumulative GPA: {cumulativeGpa}")
                    print("\n")

                    # Check semester 2 data for the student
                    cursor.execute("SELECT moduleCode, grade FROM moduleDetails WHERE studentID = %s AND semester = '2'", (studentId,))
                    semester2Data = cursor.fetchall()
                    print(semester2Data)

                    processedStudentIds.add(studentId)  # Add student ID to processed list

                    # Add calculated GPAs to the record
                    record['semester1Gpa'] = semester1Gpa
                    record['semester2Gpa'] = semester2Gpa
                    record['cumulativeGpa'] = cumulativeGpa

                    processedStudentRecords.append(record)

        return processedStudentRecords

    except mysql.connector.Error as err:
        print("Error accessing database:", err)
        return []

    finally:
        conn.close()

'''
# Example usage
desiredYear = '2019'
desiredGpa = 2.5
processStudentRecords(desiredYear, desiredGpa)
'''

class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()

        # Set window title
        self.setWindowTitle("Student Records")

        # Set window size
        self.setFixedSize(1024, 768)

        # Create central widget and layout
        centralWidget = QWidget()
        layout = QVBoxLayout()

        # Add labels and text boxes for search criteria
        labelDesiredGpa = QLabel("Please enter desired GPA:")
        self.textboxDesiredGpa = QLineEdit("2.2")  # Default value
        labelDesiredYear = QLabel("Please enter desired year:")
        self.textboxDesiredYear = QLineEdit("2020")

        # Add search button
        searchButton = QPushButton("Search")
        searchButton.clicked.connect(self.searchRecords)

        # Add labels and text boxes to layout
        layout.addWidget(labelDesiredGpa)
        layout.addWidget(self.textboxDesiredGpa)
        layout.addWidget(labelDesiredYear)
        layout.addWidget(self.textboxDesiredYear)
        layout.addWidget(searchButton)

        # Create table widget
        self.tableWidget = QTableWidget()
        self.tableWidget.setColumnCount(5)
        self.tableWidget.setHorizontalHeaderLabels(
            ["Student ID", "Student Name", "Semester 1 GPA", "Semester 2 GPA", "Cumulative GPA"])

        # Add table widget to layout
        layout.addWidget(self.tableWidget)

        # Set layout for central widget
        centralWidget.setLayout(layout)
        self.setCentralWidget(centralWidget)

    def searchRecords(self):
        desiredGpa = float(self.textboxDesiredGpa.text())
        desiredYear = self.textboxDesiredYear.text()

        try:
            # Call processStudentRecords to fetch records
            studentRecords = processStudentRecords(desiredYear, desiredGpa)

            # Clear table
            self.tableWidget.setRowCount(0)

            # Iterate over fetched records
            for record in studentRecords:
                studentId = record['studentID']
                studentName = f"{record['studentFirstName']} {record['studentSurname']}"
                semester1Gpa = record['semester1Gpa']
                semester2Gpa = record['semester2Gpa']
                cumulativeGpa = record['cumulativeGpa']

                # Create a new row
                rowPosition = self.tableWidget.rowCount()
                self.tableWidget.insertRow(rowPosition)

                # Populate columns with student data
                self.tableWidget.setItem(rowPosition, 0, QTableWidgetItem(studentId))
                self.tableWidget.setItem(rowPosition, 1, QTableWidgetItem(studentName))
                self.tableWidget.setItem(rowPosition, 2, QTableWidgetItem(str(semester1Gpa)))
                self.tableWidget.setItem(rowPosition, 3, QTableWidgetItem(str(semester2Gpa)))
                self.tableWidget.setItem(rowPosition, 4, QTableWidgetItem(str(cumulativeGpa)))

        except Exception as e:
            print("Error:", e)


if __name__ == "__main__":
    app = QApplication([])
    window = MainWindow()
    window.show()
    app.exec_()

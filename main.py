import traceback
import mysql.connector
from PyQt5.QtGui import QFont
from PyQt5.QtWidgets import QMessageBox
from PyQt5.QtGui import QTextDocument, QTextCursor, QFontDatabase
from PyQt5.QtPrintSupport import QPrinter
from PyQt5.QtWidgets import QApplication, QMainWindow, QWidget, QVBoxLayout, QHBoxLayout, QLabel, QLineEdit, \
    QPushButton, QTableWidget, QTableWidgetItem, QHeaderView, QSizePolicy
from PyQt5.QtCore import Qt
from fpdf import FPDF

def calculate_semester_gpa(student_id, semester):
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
        cursor.execute(query, (student_id, semester))
        modules = cursor.fetchall()

        total_grade_points = 0
        total_credits = 0

        for module in modules:
            grade_value = module[1]
            credits = module[2]
            grade_points_earned = grade_value * credits
            total_grade_points += grade_points_earned
            total_credits += credits

        if total_credits == 0:
            return {'total_grade_points': 0, 'total_credits': 0, 'semester_gpa': 0}  # Return a dictionary
        else:
            semester_gpa = total_grade_points / total_credits
            return {'total_grade_points': total_grade_points, 'total_credits': total_credits,
                    'semester_gpa': float(semester_gpa)}  # Convert semester_gpa to float

    except mysql.connector.Error as err:
        print("Error accessing database:", err)
        return None

    finally:
        cursor.close()
        conn.close()


def calculate_cumulative_gpa(semester1_gpa, semester2_gpa):
    if semester1_gpa is None and semester2_gpa is None:
        return None
    elif semester1_gpa is None:
        return semester2_gpa
    elif semester2_gpa is None:
        return semester1_gpa

    total_grade_points = semester1_gpa['total_grade_points'] + semester2_gpa['total_grade_points']
    total_credits = semester1_gpa['total_credits'] + semester2_gpa['total_credits']

    if total_credits == 0:
        return {'total_grade_points': 0, 'total_credits': 0, 'cumulative_gpa': 0}  # Return a dictionary
    else:
        cumulative_gpa = total_grade_points / total_credits
        return {'total_grade_points': total_grade_points, 'total_credits': total_credits,
                'cumulative_gpa': float(cumulative_gpa)}  # Convert cumulative_gpa to float

def fetch_module_details(student_id, year):
    conn = mysql.connector.connect(
        host='localhost',
        user='root',
        password='password',
        database='ProbationSystem'
    )
    cursor = conn.cursor()

    try:
        # Retrieve module details for the student in the given year and semester
        query_sem1 = """
            SELECT 
                md.moduleCode, md.studentID, mm.numOfCredits, lg.letterGrade, lg.gradeValue,
                sm.studentFirstName, sm.studentSurname
            FROM 
                moduleDetails md
            INNER JOIN 
                letterGrades lg ON md.grade = lg.letterGrade
            INNER JOIN 
                studentMaster sm ON md.studentID = sm.studentID
            INNER JOIN
                moduleMaster mm ON md.moduleCode = mm.moduleCode
            WHERE 
                md.studentID = %s AND md.moduleYear = %s AND md.semester = '1'
        """
        cursor.execute(query_sem1, (student_id, year))
        module_details_sem1 = cursor.fetchall()
        print(module_details_sem1)

        query_sem2 = """
            SELECT 
                md.moduleCode, md.studentID, mm.numOfCredits, lg.letterGrade, lg.gradeValue,
                sm.studentFirstName, sm.studentSurname
            FROM 
                moduleDetails md
            INNER JOIN 
                letterGrades lg ON md.grade = lg.letterGrade
            INNER JOIN 
                studentMaster sm ON md.studentID = sm.studentID
            INNER JOIN
                moduleMaster mm ON md.moduleCode = mm.moduleCode
            WHERE 
                md.studentID = %s AND md.moduleYear = %s AND md.semester = '2'
        """
        cursor.execute(query_sem2, (student_id, year))
        module_details_sem2 = cursor.fetchall()
        print(module_details_sem2)

        return module_details_sem1, module_details_sem2

    except mysql.connector.Error as err:
        print("Error accessing database:", err)
        return None, None

    finally:
        cursor.close()
        conn.close()


def generate_pdf(student_id, year):
    try:
        # Call fetch_module_details to get module details for the student
        module_details_sem1, module_details_sem2 = fetch_module_details(student_id, year)

        # Create PDF object
        pdf = FPDF()
        pdf.set_auto_page_break(auto=True, margin=15)

        # Add a page
        pdf.add_page()

        # Set font for the report title
        pdf.set_font("Arial", size=16)

        # Add report title
        pdf.cell(200, 10, txt=f"Student Report", ln=True, align="C")

        if module_details_sem1:
            # Add a break or new line before semester 1 table
            pdf.ln(10)
            # Add semester 1 title
            pdf.cell(200, 10, txt="Semester 1", ln=True, align="C")
            # Generate table for semester 1
            generate_table(pdf, module_details_sem1)

        if module_details_sem2:
            # Add a break or new line before semester 2 table
            pdf.ln(10)
            # Add semester 2 title
            pdf.cell(200, 10, txt="Semester 2", ln=True, align="C")
            # Generate table for semester 2
            generate_table(pdf, module_details_sem2)

        # Save the PDF to a file
        pdf_output = f"{student_id}_report.pdf"
        pdf.output(pdf_output)

        QMessageBox.information(None, "Report Generated",
                                f"Student report has been generated as '{pdf_output}'.")

    except Exception as e:
        traceback.print_exc()  # Print traceback for debugging
        QMessageBox.critical(None, "Error", f"An error occurred: {str(e)}")


def generate_table(pdf, module_details):
    # Set font for the table
    pdf.set_font("Arial", size=12)

    # Add headers
    pdf.cell(30, 10, "Module", 1)
    for module in module_details:
        module_code = module[0]
        pdf.cell(30, 10, module_code, 1)
    pdf.cell(30, 10, "Total", 1)
    pdf.ln()

    # Add credits row
    pdf.cell(30, 10, "Credits", 1)
    for module in module_details:
        credits = module[2]
        pdf.cell(30, 10, str(credits), 1)
    total_credits = sum(module[2] for module in module_details)
    pdf.cell(30, 10, str(total_credits), 1)
    pdf.ln()

    # Add grade row
    pdf.cell(30, 10, "Grade", 1)
    for module in module_details:
        grade = module[3]
        pdf.cell(30, 10, grade, 1)
    pdf.cell(30, 10, "", 1)  # Empty cell for Total
    pdf.ln()

    # Add grade points row
    pdf.cell(30, 10, "Grade Points", 1)
    for module in module_details:
        grade_points = module[4]
        pdf.cell(30, 10, str(grade_points), 1)
    pdf.cell(30, 10, "", 1)  # Empty cell for Total
    pdf.ln()

    # Add grade points earned row
    pdf.cell(30, 10, "Points Earned", 1)
    for module in module_details:
        credits = module[2]
        grade_points = module[4]
        grade_points_earned = round(credits * float(grade_points), 2)
        pdf.cell(30, 10, str(grade_points_earned), 1)
    total_grade_points_earned = sum(module[2] * float(module[4]) for module in module_details)
    pdf.cell(30, 10, str(total_grade_points_earned), 1)
    pdf.ln()

    # Calculate GPA
    if total_credits == 0:
        gpa = 0
    else:
        gpa = total_grade_points_earned / total_credits

    # Add GPA row
    pdf.cell(30, 10, "GPA", 1)
    pdf.cell(30 * len(module_details), 10, "", 1)  # Empty cells for modules
    pdf.cell(30, 10, f"{gpa:.2f}", 1)
    pdf.ln()

def process_student_records(year, desired_gpa):
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
        student_records = cursor.fetchall()

        processed_student_ids = set()
        processed_student_records = []

        for record in student_records:
            student_id = record['studentID']
            student_name = f"{record['studentFirstName']} {record['studentSurname']}"
            total_credits = record['totalCredits']

            # Calculate semester GPA
            semester1_gpa = calculate_semester_gpa(student_id, 1)
            semester2_gpa = calculate_semester_gpa(student_id, 2)

            # Calculate cumulative GPA
            cumulative_gpa = calculate_cumulative_gpa(semester1_gpa, semester2_gpa)

            # Check if the student meets the desired GPA criteria
            if desired_gpa is None or (total_credits != 0 and cumulative_gpa['cumulative_gpa'] >= desired_gpa):

                # Print student information if not already processed
                if student_id not in processed_student_ids:
                    print(f"Student ID: {student_id}")
                    print(f"Student Name: {student_name}")
                    print(f"Semester 1 GPA: {semester1_gpa}")
                    print(f"Semester 2 GPA: {semester2_gpa}")
                    print(f"Cumulative GPA: {cumulative_gpa}")
                    print("\n")

                    # Check semester 2 data for the student
                    cursor.execute("SELECT moduleCode, grade FROM moduleDetails WHERE studentID = %s AND semester = '2'", (student_id,))
                    semester2_data = cursor.fetchall()
                    print(semester2_data)

                    processed_student_ids.add(student_id)  # Add student ID to processed list

                    # Add calculated GPAs to the record
                    record['semester1_gpa'] = semester1_gpa
                    record['semester2_gpa'] = semester2_gpa
                    record['cumulative_gpa'] = cumulative_gpa

                    processed_student_records.append(record)

        return processed_student_records

    except mysql.connector.Error as err:
        print("Error accessing database:", err)
        return []

    finally:
        conn.close()

# Handling the GUI
class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()

        # Set window title
        self.setWindowTitle("Student Records")

        # Set window size
        self.setFixedSize(1024, 768)

        # Create central widget and layout
        central_widget = QWidget()
        layout = QVBoxLayout()

        # Create top widget and layout
        top_widget = QWidget()
        top_layout = QHBoxLayout()

        # Add labels and text boxes for search criteria
        label_desired_gpa = QLabel("Please enter desired GPA:")
        self.textbox_desired_gpa = QLineEdit("2.2")  # Default value
        label_desired_year = QLabel("Please enter desired year:")
        self.textbox_desired_year = QLineEdit("2020")

        # Add search button
        self.search_button = QPushButton("Search")
        self.search_button.clicked.connect(self.search_records)

        # Increase size of size button
        self.search_button.setFixedHeight(30)

        # Add generate report button
        self.generate_report_button = QPushButton("Generate Report")
        self.generate_report_button.setEnabled(False)  # Initially disabled
        self.generate_report_button.clicked.connect(self.generate_report)

        # Increase size of generate report button
        self.generate_report_button.setFixedHeight(30)
        self.generate_report_button.setSizePolicy(QSizePolicy.Expanding, QSizePolicy.Fixed)

        # Add labels and text boxes to top layout
        top_layout.addWidget(label_desired_gpa)
        top_layout.addWidget(self.textbox_desired_gpa)
        top_layout.addWidget(label_desired_year)
        top_layout.addWidget(self.textbox_desired_year)
        top_layout.addWidget(self.search_button)

        # Add generate report button to top layout
        top_layout.addWidget(self.generate_report_button)

        # Set top layout for top widget
        top_widget.setLayout(top_layout)

        # Create table widget
        self.table_widget = QTableWidget()
        self.table_widget.setColumnCount(5)
        self.table_widget.setHorizontalHeaderLabels(
            ["Student ID", "Student Name", "Semester 1 GPA", "Semester 2 GPA", "Cumulative GPA"])

        # Set table properties
        self.table_widget.setEditTriggers(QTableWidget.NoEditTriggers)  # Make cells uneditable
        self.table_widget.horizontalHeader().setSectionResizeMode(QHeaderView.Stretch)  # Expand columns to fill space
        self.table_widget.setSelectionBehavior(QTableWidget.SelectRows)  # Select entire rows

        # Connect selection changed signal to enable/disable generate report button
        self.table_widget.selectionModel().selectionChanged.connect(self.enable_generate_report_button)

        # Add top widget and table widget to main layout
        layout.addWidget(top_widget)
        layout.addWidget(self.table_widget)

        # Set layout for central widget
        central_widget.setLayout(layout)
        self.setCentralWidget(central_widget)

    def search_records(self):
        desired_gpa = float(self.textbox_desired_gpa.text())
        desired_year = self.textbox_desired_year.text()

        try:
            # Call process_student_records to fetch records
            student_records = process_student_records(desired_year, desired_gpa)

            # Clear table
            self.table_widget.setRowCount(0)

            # Iterate over fetched records
            for record in student_records:
                student_id = record['studentID']
                student_name = f"{record['studentFirstName']} {record['studentSurname']}"
                semester1_gpa = round(record['semester1_gpa']['semester_gpa'], 2)
                semester2_gpa = round(record['semester2_gpa']['semester_gpa'], 2)
                cumulative_gpa = round(record['cumulative_gpa']['cumulative_gpa'], 2)

                # Create a new row
                row_position = self.table_widget.rowCount()
                self.table_widget.insertRow(row_position)

                # Populate columns with student data
                self.table_widget.setItem(row_position, 0, QTableWidgetItem(student_id))
                self.table_widget.setItem(row_position, 1, QTableWidgetItem(student_name))

                # Set alignment for GPA columns
                for col, gpa in enumerate([semester1_gpa, semester2_gpa, cumulative_gpa], start=2):
                    item = QTableWidgetItem(str(gpa))
                    item.setTextAlignment(Qt.AlignCenter)
                    self.table_widget.setItem(row_position, col, item)

        except Exception as e:
            print("Error:", e)

    # Function to generate report specific to selected student
    def generate_report(self):
        try:
            # Placeholder function to generate PDF
            print("Generating PDF...")
            selected_row = self.table_widget.currentRow()  # Get the index of the selected row
            if selected_row != -1:  # Check if a row is selected
                student_id = self.table_widget.item(selected_row, 0).text()
            year = self.textbox_desired_year.text()
            generate_pdf(student_id, year)
        except Exception as e:
            traceback.print_exc()  # Print traceback for debugging
            QMessageBox.critical(None, "Error", f"An error occurred: {str(e)}")
        print("PDF generated!")

    def enable_generate_report_button(self):
        # Enable generate report button if a row is selected, disable otherwise
        selected_rows = self.table_widget.selectionModel().selectedRows()
        self.generate_report_button.setEnabled(len(selected_rows) > 0)

if __name__ == "__main__":
    app = QApplication([])
    window = MainWindow()
    window.show()
    app.exec_()

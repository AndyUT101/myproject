from django.http import HttpResponse, HttpResponseRedirect, HttpResponseNotFound

import io
import xlsxwriter

def export_excel(xlsx_data):
    response = HttpResponse(content_type='application/vnd.ms-excel')
    response['Content-Disposition'] = 'attachment; filename=Report.xlsx'
    data = xlsx_data
    response.write(data)

    return response

def attendance_xls(raw_data, class_code, attend_date):
    output = io.BytesIO()
    workbook = xlsxwriter.Workbook(output)

    worksheet_s = workbook.add_worksheet("Attendance")
    worksheet_s.set_column('B:B', 10)
    worksheet_s.set_column('C:C', 15)
    worksheet_s.set_column('D:D', 30)
    worksheet_s.set_column('E:E', 15)
    title = workbook.add_format({
        'bold': True,
        'font_size': 14,
        'align': 'center',
        'valign': 'vcenter'
    })
    header = workbook.add_format({
        'bg_color': '#F7F7F7',
        'color': 'black',
        'align': 'center',
        'valign': 'top',
        'border': 1
    })

    title_text = "Attendance report of " + class_code
    worksheet_s.merge_range('B2:E2', title_text, title)

    date_text = "Date: " + attend_date
    worksheet_s.merge_range('B3:E3', date_text, title)

    worksheet_s.write(4, 1, "Class", header)
    worksheet_s.write(4, 2, "Class number", header)
    worksheet_s.write(4, 3, "Name", header)
    worksheet_s.write(4, 4, "Status", header)

    for index, key in enumerate(raw_data):
        row = 5 + index
        output_data = raw_data[key]
        worksheet_s.write(row, 1, class_code, header)
        worksheet_s.write(row, 2, output_data[0], header)
        worksheet_s.write(row, 3, output_data[1].firstname + " " + output_data[1].lastname, header)
        worksheet_s.write(row, 4, output_data[2], header)


    workbook.close()
    xlsx_data = output.getvalue()

    return xlsx_data

def all_student_class(class_contents):
    output = io.BytesIO()
    workbook = xlsxwriter.Workbook(output)

    class_code_key = sorted(list(class_contents.keys()))
    for class_code in class_code_key:
        worksheet_s = workbook.add_worksheet(class_code)
        worksheet_s.set_column('B:B', 10)
        worksheet_s.set_column('C:C', 15)
        worksheet_s.set_column('D:D', 30)
        worksheet_s.set_column('E:E', 15)
        title = workbook.add_format({
            'bold': True,
            'font_size': 14,
            'align': 'center',
            'valign': 'vcenter'
        })
        header = workbook.add_format({
            'bg_color': '#F7F7F7',
            'color': 'black',
            'align': 'center',
            'valign': 'top',
            'border': 1
        })

        title_text = class_code + " students"
        worksheet_s.merge_range('B2:E2', title_text, title)

        worksheet_s.write(4, 1, "Class number", header)
        worksheet_s.write(4, 2, "Name", header)
        worksheet_s.write(4, 3, "Sex", header)
        worksheet_s.write(4, 4, "Checkbox", header)

        for index, content in enumerate(class_contents[class_code]):
            row = 5 + index
            if len(content) == 0:
                continue
            worksheet_s.write(row, 1, content[0], header)
            worksheet_s.write(row, 2, content[1], header)
            worksheet_s.write(row, 3, content[2], header)
            worksheet_s.write(row, 4, "", header)


    workbook.close()
    xlsx_data = output.getvalue()

    return xlsx_data

def all_student(class_contents):
    output = io.BytesIO()
    workbook = xlsxwriter.Workbook(output)

    worksheet_s = workbook.add_worksheet("Attendance")
    title = workbook.add_format({
        'bold': True,
        'font_size': 14,
        'align': 'center',
        'valign': 'vcenter'
    })
    header = workbook.add_format({
        'bg_color': '#F7F7F7',
        'color': 'black',
        'align': 'center',
        'valign': 'top',
        'border': 1
    })

    title_text = "Student information report"
    worksheet_s.merge_range('B2:E2', title_text, title)
    
    wb_header = ['Class', 'Class number', 'Student name', 'Sex code', 'Card id', 'Strn code', 'birthday', 'email']
    for index, key in enumerate(wb_header, 1):
        set_header = header
        if index == 7:
            set_header = workbook.add_format({'num_format': 'yyyy/mm/dd'})
        worksheet_s.write(4, index, key, set_header)

    for index, key in enumerate(class_contents):
        row = 5 + index
        output_data = key
        for ix, kx in enumerate(wb_header):
            worksheet_s.write(row, ix+1, output_data[ix], header)

    workbook.close()
    xlsx_data = output.getvalue()

    return xlsx_data
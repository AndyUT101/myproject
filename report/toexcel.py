from django.http import HttpResponse, HttpResponseRedirect, HttpResponseNotFound

import io
import xlsxwriter

def export_excel(xlsx_data):
    response = HttpResponse(content_type='application/vnd.ms-excel')
    response['Content-Disposition'] = 'attachment; filename=Report.xlsx'
    data = xlsx_data
    response.write(data)

    return response

def attendance_xls(raw_data, class_code):
    output = io.BytesIO()
    workbook = xlsxwriter.Workbook(output)

    worksheet_s = workbook.add_worksheet("Attendance")
    worksheet_s.set_column(1, 1, 15)
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
    worksheet_s.merge_range('B2:H2', title_text, title)

    worksheet_s.write(4, 0, "Class", header)
    worksheet_s.write(4, 1, "Class number", header)
    worksheet_s.write(4, 2, "Name", header)
    worksheet_s.write(4, 3, "Status", header)


    workbook.close()
    xlsx_data = output.getvalue()

    return xlsx_data


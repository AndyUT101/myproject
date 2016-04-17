from django.http import HttpResponse, HttpResponseRedirect, HttpResponseNotFound

from io import StringIO
import xlsxwriter

def export_excel(xlsx_data):
    response = HttpResponse(content_type='application/vnd.ms-excel')
    response['Content-Disposition'] = 'attachment; filename=Report.xlsx'
    xlsx_data = xlsx_data
    response.write(xlsx_data)

    return response

def attendance_xls(raw_data, class_code):
    output = StringIO()
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

    title_text = "{0} {1}".format(ugettext("Weather History for"), class_code)
    worksheet_s.merge_range('B2:H2', title_text, title)

    worksheet_s.write(4, 0, ugettext("Class"), header)
    worksheet_s.write(4, 1, ugettext("Class number"), header)
    worksheet_s.write(4, 2, ugettext("Name"), header)
    worksheet_s.write(4, 3, ugettext("Status"), header)


    workbook.close()
    xlsx_data = output.getvalue()

    return xlsx_data
from io import StringIO
import xlsxwriter

def Write_xlsx(data, title = 'schoolpro_report' filter = None):
    output = StringIO.StringIO()
    workbook = xlsxwriter.Workbook(output)

    # Process data to excel


    workbook.close()
    xlsx_data = output.getvalue()

    return xlsx_data
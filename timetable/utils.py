from datetime import datetime
import calendar

def generate_calender(year=datetime.now().year , month=datetime.now().month):
    return calendar.HTMLCalendar(calendar.SUNDAY).formatmonth(year, month)
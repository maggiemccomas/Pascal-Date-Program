
(* 
File Name: dt.pas
Author: Maggie McComas
This Pascal Program works with dates doing functions such as setting, incrementing,
and comparing the dates and printing the results to the screen.
*)

program dt;
uses sysutils;


type
    day_range = 1 .. 31;
    month_range = 1 .. 12;

    date_t = record
        Month: month_range;
        Day: day_range;
        Year: integer;
    end;

(*
Purpose: initializes dt with the given day, month, and year
Input: date_t dt which is a record type, day_range day which is an int in the subrange 1-31,
month_range month which is an int in the subrange 1-12, integer year.
Output: none
*)
procedure init_date (var dt : date_t; day : day_range; month : month_range; year : integer);
begin
    dt.Month := month;
    dt.Day := day;
    dt.Year := year;
end;

(*
Purpose: initializes dt with the current date
Input: date_t dt which is a record type
Output: none
*)
procedure init_date1 (var dt : date_t);
var
    month, day, year : word;
begin
    DecodeDate(Date, year, month, day);
    dt.Month := month;
    dt.Day := day;
    dt.year := year;
end;

(*
Purpose: compares two dates and returns true if they're equal otherwise it returns false
Input: date_t date1 which is a record type and date_t date2 which is a record type
Output: boolean date_equal
*)
function date_equal (date1 : date_t; date2 : date_t) : boolean;
var
    exit: boolean;
begin
    exit := true;

    if (date1.Month <> date2.Month) then
        exit := false
    else if (date1.Day <> date2.Day) then
        exit := false
    else if (date1.Year <> date2.Year) then
        exit := false;

    date_equal := exit;
end;

(*
Purpose: compares two dates and returns true if date1 is less than date2, otherwise it returns false
Input: date_t date1 which is a record type and date_t date2 which is a record type
Output: boolean date_less_than
*)
function date_less_than (date1 : date_t; date2 : date_t) : boolean;
var
    exit : boolean;
begin
    exit := true;

    if (date1.Year > date2.Year) then
        exit := false
    else if (date1.Year = date2.Year) then
        if (date1.Month > date2.Month) then
            exit := false
        else if (date1.Month = date2.Month) then
            if (date1.Day >= date2.Day) then
                exit := false;

    date_less_than := exit;
end;

(*
Purpose: returns string name corresponding to month number
Input: month_range month which is an int in the subrange 1-12
Output: string month_str
*)
function month_str (month : month_range) : string;
var
    exit : string;
begin
    case (month) of
        1 : exit := 'January';
        2 : exit := 'February';
        3 : exit := 'March';
        4 : exit := 'April';
        5 : exit := 'May';
        6 : exit := 'June';
        7 : exit := 'July';
        8 : exit := 'August';
        9 : exit := 'September';
        10 : exit := 'October';
        11 : exit := 'November';
        12 : exit := 'December';
        end;

    month_str := exit;
end;

(*
Purpose: formats a date with month day, year format
Input: date_t dt which is a record type, string ret_str which is the string being formatted
Output: none
*)
procedure format_date (dt : date_t; var ret_str : string);
var
    month : string;
begin
month := month_str(dt.Month);
ret_str := month + ' ' + IntToStr(dt.Day) + ', ' + IntToStr(dt.Year);
end;

(*
Purpose: increments dt by one day
Input: date_t dt which is a record type and the day being incremented.
Output: none
*)
procedure next_day (var dt : date_t);
var
    temp, curMonthLeng : integer;
    leapYear : boolean;

    (*
    Purpose: returns true if the given year is a leap year, otherwise false
    Input: integer year
    Output: boolean leap_year
    *)
    function leap_year (year : integer) : boolean;
    var
        exit : boolean;
    begin

        if (year mod 4 = 0) then
            if (year mod 100 = 0) then
                if (year mod 400 = 0) then
                    exit := true 
                else
                    exit := false
            else
                exit := true
        else
            exit := false;

        leap_year := exit;
    end;

    (*
    Purpose: returns the number of days the given month
    Input: month_range month which is an int in the subrange 1-12, boolean leap 
    which is true if the year is a leap year, otherwise false
    Output: day_range month_length which is an int in subrange 1-31
    *)
    function month_length (month : month_range; leap : boolean) : day_range;
    var
        exit : day_range;
    begin
        
        case (month) of
            1, 3, 5, 7, 8, 10, 12 : exit := 31;
            4, 6, 9, 11 : exit := 30;
            2 : 
                if (leap = true) then
                    exit := 29
                else
                    exit := 28;
        end;

        month_length := exit;
    end;

begin
    temp := dt.Day + 1;
    leapYear := leap_year(dt.Year);
    curMonthLeng := month_length(dt.Month, leapYear);

    if (temp <= curMonthLeng) then
        dt.Day := temp
    else
        case (dt.Month) of
        1 .. 11 : 
            begin
                dt.Month := dt.Month + 1;
                dt.Day := 1
            end;
        12 : 
            begin
                dt.Month := 1;
                dt.Day := 1;
                dt.Year := dt.Year + 1
            end;
        end;
        
end;

(*
Purpose: this is the main method of the program, which is responsible for defining 
and initializing variables d1, d2, d3, and format_str. It is also responsible for
calling the above written functions and printing the desired outputs to the screen.
Input: none
Output: multiple print statements
*)
var
    d1, d2, d3 : date_t;
    format_str : string;
begin
    init_date1(d1);
    init_date(d2, 30, 12, 1999);
    init_date(d3, 1, 1, 2000);

    format_date(d1, format_str);
    writeln('d1: ' + format_str);

    format_date(d2, format_str);
    writeln('d2: ' + format_str);

    format_date(d3, format_str);
    writeln('d3: ' + format_str);

    writeln();

    if (date_less_than(d1, d3) = true) then
        format_str := 'TRUE'
    else
        format_str := 'FALSE';
    writeln('d1 < d2? ' + format_str);

    if (date_less_than(d2, d3) = true) then
        format_str := 'TRUE'
    else
        format_str := 'FALSE';
    writeln('d2 < d3? ' + format_str);

    writeln();

    next_day(d2);
    format_date(d2, format_str);
    writeln('next day d2: ' + format_str);

    if (date_less_than(d2, d3) = true) then
        format_str := 'TRUE'
    else
        format_str := 'FALSE';
    writeln('d2 < d3? ' + format_str);

    if (date_equal(d2, d3) = true) then
        format_str := 'TRUE'
    else
        format_str := 'FALSE';
    writeln('d2 = d3? ' + format_str);

    if (date_less_than(d3, d2) = true) then
        format_str := 'TRUE'
    else
        format_str := 'FALSE';
    writeln('d2 > d3? ' + format_str);

    writeln();

    next_day(d2);
    format_date(d2, format_str);
    writeln('next day d2: ' + format_str);

    if (date_equal(d2, d3) = true) then
        format_str := 'TRUE'
    else
        format_str := 'FALSE';
    writeln('d2 = d3? ' + format_str);

    writeln();

    init_date(d1, 28, 2, 1529);
    format_date(d1, format_str);
    writeln('initialized d1 to ' + format_str);

    next_day(d1);
    format_date(d1, format_str);
    writeln('next day d1: ' + format_str);

    writeln();

    init_date(d1, 28, 2, 1460);
    format_date(d1, format_str);
    writeln('initialized d1 to ' + format_str);

    next_day(d1);
    format_date(d1, format_str);
    writeln('next day d1: ' + format_str);

    writeln();

    init_date(d1, 28, 2, 1700);
    format_date(d1, format_str);
    writeln('initialized d1 to ' + format_str);

    next_day(d1);
    format_date(d1, format_str);
    writeln('next day d1: ' + format_str);

    writeln();

    init_date(d1, 28, 2, 1600);
    format_date(d1, format_str);
    writeln('initialized d1 to ' + format_str);

    next_day(d1);
    format_date(d1, format_str);
    writeln('next day d1: ' + format_str);
end.
# -*- coding: cp932 -*-
require 'win32ole'
Xldown        = -4121
Xlright       = -4161
Xlcalcmanual  = -4135
Xlcalcauto    = -4105
Xlblack       = 1
Xlwhite       = 2
Xlred         = 3
Xlgreenyellow = 4
Xlblue        = 5
Xlyellow      = 6
Xlpink        = 7
Xlskyblue     = 8
Xlbrown       = 9
Xlgray25      = 15
Xlgray50      = 16
Xlcenter      = -4108
Xlleft        = -4131
Xlright       = -4152

HANKAKU   = "-a-zA-Z0-9() ¥+?:;=!#$%&/_^~.¤±²³´µ¶·¸¹º»¼½¾¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜ¦Ý§¨©ª«¯¬­®TUVWXYZ[\"
ZENKAKU   = "|-`-yO-Xij@E{HFGI^QO DAACEGIJLNPRTVXZ\^`cegijklmnqtwz}~@BDFHbPQRSTUVWX"

HAN = {
  ["Þ", "³"] => "",
  ["Þ", "¶"] => "K",
  ["Þ", "·"] => "M",
  ["Þ", "¸"] => "O",
  ["Þ", "¹"] => "Q",
  ["Þ", "º"] => "S",
  ["Þ", "»"] => "U",
  ["Þ", "¼"] => "W",
  ["Þ", "½"] => "Y",
  ["Þ", "¾"] => "[",
  ["Þ", "¿"] => "]",
  ["Þ", "À"] => "_",
  ["Þ", "Á"] => "a",
  ["Þ", "Â"] => "d",
  ["Þ", "Ã"] => "f",
  ["Þ", "Ä"] => "h",
  ["Þ", "Ê"] => "o",
  ["Þ", "Ë"] => "r",
  ["Þ", "Ì"] => "u",
  ["Þ", "Í"] => "x",
  ["Þ", "Î"] => "{",
  ["ß", "Ê"] => "p",
  ["ß", "Ë"] => "s",
  ["ß", "Ì"] => "v",
  ["ß", "Í"] => "y",
  ["ß", "Î"] => "|"
}

ZEN = {
  "" => ["³", "Þ"],
  "K" => ["¶", "Þ"],
  "M" => ["·", "Þ"],
  "O" => ["¸", "Þ"],
  "Q" => ["¹", "Þ"],
  "S" => ["º", "Þ"],
  "U" => ["»", "Þ"],
  "W" => ["¼", "Þ"],
  "Y" => ["½", "Þ"],
  "[" => ["¾", "Þ"],
  "]" => ["¿", "Þ"],
  "_" => ["À", "Þ"],
  "a" => ["Á", "Þ"],
  "d" => ["Â", "Þ"],
  "f" => ["Ã", "Þ"],
  "h" => ["Ä", "Þ"],
  "o" => ["Ê", "Þ"],
  "r" => ["Ë", "Þ"],
  "u" => ["Ì", "Þ"],
  "x" => ["Í", "Þ"],
  "{" => ["Î", "Þ"],
  "p" => ["Ê", "ß"],
  "s" => ["Ë", "ß"],
  "v" => ["Ì", "ß"],
  "y" => ["Í", "ß"],
  "|" => ["Î", "ß"],
  "[" => "-"
}

SHIBU = { 
  "10" => "k", "11" => "ã", "12" => "", "13" => "º",
  "14" => "ì", "15" => "¶", "16" => "R", "17" => "RÈ",
  "18" => "E", "19" => "¼", "20" => "©",
  "21" => "çí", "50" => "³P", "51" => "F¡", "53" => "Tª",
  "54" => "Dä", "56" => "»", "57" => "mR", "58" => "ß",
  "59" => "{Ã", "60" => "Oã", "61" => "y", "62" => "ì",
  "63" => "Ôìª¦",
  "85" => "@l", "90" => "\ï", "95" => "dC",
}

SHIBU_VERSE = SHIBU.invert
SHIBU2 = { 
  "10" => "k", "11" => "ã", "12" => "", "13" => "º",
  "14" => "ì", "15" => "¶", "16" => "", "17" => "R",
  "18" => "E", "19" => "¼", "20" => "",
  "21" => "ç", "50" => "³", "51" => "F", "53" => "T",
  "54" => "D", "56" => "»", "57" => "", "58" => "",
  "59" => "{", "60" => "", "61" => "", "62" => "",
  "63" => "Ô",
  "85" => "@", "90" => "\", "95" => "d",
}
SHIBU2_VERSE = SHIBU2.invert

def to_zenkaku_fold(ary, ret)
  if ary.empty?
    ret
  else
    if ( ary.first == "ß" ) or ( ary.first == "Þ" )
      to_zenkaku_fold(ary.slice(2..-1), ret.push(HAN[[ary[0], ary[1]]]))
    else
      to_zenkaku_fold(ary.slice(1..-1), ret.push(ary.first))
    end
  end
end

GENGOU = {
  "¾¡" => 1867, "¾" => 1867, "M" => 1867, "m" => 1867,
  "å³" => 1911, "å" => 1911, "T" => 1911, "t" => 1911,
  "ºa" => 1925, "º" => 1925, "S" => 1925, "s" => 1925,
  "½¬" => 1988, "½" => 1988, "H" => 1988, "h" => 1988
}

def jdate2roman(gengou, year)
  return GENGOU[gengou] + year;
end


class String
  def string_to_date
    if self =~ /(\d{4})(\d{2})(\d{2})/
      (year, month, day) = $~.captures
      return Date::new(year.to_i, month.to_i, day.to_i);
    elsif self =~ /(\d{4})[-\/\.N][ @]*(\d{1,2})[-\/\.][ @]*(\d{1,2})/
      (year, month, day) = $~.captures
      return Date::new(year.to_i, month.to_i, day.to_i);
    elsif self =~ /(¾¡|å³|ºa|½¬)[ @]*(\d{2})[-\/\.N][ @]*(\d{1,2})[-\/\.][ @]*(\d{1,2})/
      (gengou, year, month, day) = $~.captures
      return Date::new(jdate2roman(gengou, year.to_i), month.to_i, day.to_i);
    elsif self =~ /([¾åº½MmTtSsHh])[ @]*(\d{2})[-\/\.N][ @]*(\d{1,2})[-\/\.][ @]*(\d{1,2})/
      (gengou, year, month, day) = $~.captures
      return Date::new(jdate2roman(gengou, year.to_i), month.to_i, day.to_i);
    elsif self =~ /H(\d{2})(\d{2})(\d{2})/
      (year, month, day) = $~.captures
      return Date::new(jdate2roman("H", year.to_i), month.to_i, day.to_i);
    else
      return nil
    end
  end

  def to_date
    self.string_to_date
  end

  def to_hankaku
    strary = self.space_chomp.chars.map{|ch|
      if ZEN.has_key?(ch)
        ZEN[ch]
      else
        ch
      end
    }
    str   = strary.flatten.inject("") {|x, y| x + y }
    return str.tr(ZENKAKU, HANKAKU)
  end
  def to_zenkaku
    strary = to_zenkaku_fold(self.space_chomp.chars.reverse, []).reverse
    str    = strary.inject("") {|x, y| x + y }
    return str.tr(HANKAKU, ZENKAKU)
  end
  def space_chomp
    self.gsub(/[ @]*$/, "")
  end
  def left(length)
	  return self.slice(0, length)
  end
end

class Date
  def normal_type_string
    self.strftime("%F").gsub(/-/, "/")
  end
end

require 'pp'
class Array
  def second
    self[1]
  end
  def any
    ret = self.map{|el| yield(el)}.delete_if{|x| x==false}
    ret.empty? ? false : true
  end
  def value_to_text
    require 'date'
    self.map{|line|
      line.map {|el|
        if el.kind_of?(Float)
          el.to_i.to_s
        elsif el.kind_of?(Date)
          el.to_s
        elsif el.kind_of?(Time)
          Date.new(el.year, el.month, el.day).to_s
        elsif not(el)
          ""
        else
          el
        end
      }
    }
  end
end

IDENTITY = lambda{|x| x}
def find_core(path, func, filter, ret)
  if File.file?(path)
    func   = func   ? func   : IDENTITY
    filter = filter ? filter : IDENTITY
    ret << func.call(path) if filter.call(path)
  elsif File.directory?(path)
    Dir["#{path}/*"].each {|p| find_core(p, func, filter, ret)}
    return ret
  end
end

def find(path, func, filter)
  find_core(path, func, filter, [])
end

class Array
  def to_hash_table(keyfn, valfn)
    h = Hash.new
    self.each {|el|
      key = keyfn.call(el)
      val = valfn.call(el)
      if h.has_key?(key)
        h[key] = h[key].push(val)
      else
        h[key] = [val]
      end
    }
    return h
  end
  def to_simple_hash(keyfn, valfn)
    h = Hash.new
    self.each{|el|
      key = keyfn.call(el); val = valfn.call(el)
      h[key] = val
    }
    return h
  end
end
def search_book(excel, filename)
  ret = Array.new
  excel.Workbooks.each {|wb| ret.push(wb) }
  # puts filename
  b = ret.find{|wb| wb.FullName == filename}
  b.Activate() if b
  return b
end

def with_excel_file_parse_opt(option)
  if option
    visible         = option.has_key?(:visible) ? option[:visible] : true
    alerts          = option.has_key?(:alerts)  ? option[:alerts]  : false
    recalc          = option.has_key?(:recalc)  ? option[:recalc]  : false
    save            = option.has_key?(:save)    ? option[:save]    : true
    close           = option.has_key?(:close)   ? option[:close]   : true
    quit            = option.has_key?(:quit)    ? option[:quit]    : true
  else
    visible         = true
    alerts          = false
    recalc          = false
    save            = true
    close           = true
    quit            = true
  end
  return [visible, alerts, recalc, save, close, quit]
end

def excel_running?()
  begin
    WIN32OLE.connect("Excel.Application")
  rescue
    return false
  end
  return true
end

def with_excel_file(filename, sheetname, option=nil)
  fil = filename.gsub("/", "\\\\")
  if excel_running?
    exc = WIN32OLE.connect("Excel.Application")
    sbo = search_book(exc, fil)
    book = sbo ? sbo : exc.Workbooks.Open(filename)
  else
    exc = WIN32OLE.new("Excel.Application")
    book = exc.Workbooks.Open(filename)
  end
  # puts book.FullName
  visible, alerts, recalc, save, close, quit = with_excel_file_parse_opt(option)
  exc.Visible       = visible;
  # exc.Calculation   = recalc ? Xlcalcauto : Xlcalcmanual
  exc.DisplayAlerts = alerts;
  sheet = book.Worksheets.Item(sheetname)
  yield(book, sheet, exc)
  book.Close('SaveChanges' => true)
  # exc.Calculation   = Xlcalcauto
  exc.DisplayAlerts = true;
  exc.Quit()# if quit
end

def with_excel()
  require 'win32ole'
  app = WIN32OLE.new('Excel.Application')
  app.Visible = true;
  app.DisplayAlerts = false;
  begin
    yield(app);
  ensure
    app.Quit();
  end
end

def with_open_book(excel_application, bookname)
  bk = excel_application.Workbooks.Open(bookname)
  begin
    yield(bk);
  ensure
    bk.Close();
  end
end

class Time
  def normal
    self.strftime("%Y/%m/%d")
  end
end

class WIN32OLE::Worksheets
  def [] y,x
    self.Cells.Item(y, x).Value
  end
end

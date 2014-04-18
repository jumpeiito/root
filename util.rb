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

HANKAKU   = "-a-zA-Z0-9() ･+?:;=!#$%&/_^~.､ｱｲｳｴｵｶｷｸｹｺｻｼｽｾｿﾀﾁﾂﾃﾄﾅﾆﾇﾈﾉﾊﾋﾌﾍﾎﾏﾐﾑﾒﾓﾔﾕﾖﾗﾘﾙﾚﾛﾜｦﾝｧｨｩｪｫｯｬｭｮⅠⅡⅢⅣⅤⅥⅦⅧⅨ"
ZENKAKU   = "－ａ-ｚＡ-Ｚ０-９（）　・＋？：；＝！＃＄％＆／＿＾ ．、アイウエオカキクケコサシスセソタチツテトナニヌネノハヒフヘホマミムメモヤユヨラリルレロワヲンァィゥェォッャュョ１２３４５６７８９"

HAN = {
  ["ﾞ", "ｳ"] => "ヴ",
  ["ﾞ", "ｶ"] => "ガ",
  ["ﾞ", "ｷ"] => "ギ",
  ["ﾞ", "ｸ"] => "グ",
  ["ﾞ", "ｹ"] => "ゲ",
  ["ﾞ", "ｺ"] => "ゴ",
  ["ﾞ", "ｻ"] => "ザ",
  ["ﾞ", "ｼ"] => "ジ",
  ["ﾞ", "ｽ"] => "ズ",
  ["ﾞ", "ｾ"] => "ゼ",
  ["ﾞ", "ｿ"] => "ゾ",
  ["ﾞ", "ﾀ"] => "ダ",
  ["ﾞ", "ﾁ"] => "ヂ",
  ["ﾞ", "ﾂ"] => "ヅ",
  ["ﾞ", "ﾃ"] => "デ",
  ["ﾞ", "ﾄ"] => "ド",
  ["ﾞ", "ﾊ"] => "バ",
  ["ﾞ", "ﾋ"] => "ビ",
  ["ﾞ", "ﾌ"] => "ブ",
  ["ﾞ", "ﾍ"] => "ベ",
  ["ﾞ", "ﾎ"] => "ボ",
  ["ﾟ", "ﾊ"] => "パ",
  ["ﾟ", "ﾋ"] => "ピ",
  ["ﾟ", "ﾌ"] => "プ",
  ["ﾟ", "ﾍ"] => "ペ",
  ["ﾟ", "ﾎ"] => "ポ"
}

ZEN = {
  "ヴ" => ["ｳ", "ﾞ"],
  "ガ" => ["ｶ", "ﾞ"],
  "ギ" => ["ｷ", "ﾞ"],
  "グ" => ["ｸ", "ﾞ"],
  "ゲ" => ["ｹ", "ﾞ"],
  "ゴ" => ["ｺ", "ﾞ"],
  "ザ" => ["ｻ", "ﾞ"],
  "ジ" => ["ｼ", "ﾞ"],
  "ズ" => ["ｽ", "ﾞ"],
  "ゼ" => ["ｾ", "ﾞ"],
  "ゾ" => ["ｿ", "ﾞ"],
  "ダ" => ["ﾀ", "ﾞ"],
  "ヂ" => ["ﾁ", "ﾞ"],
  "ヅ" => ["ﾂ", "ﾞ"],
  "デ" => ["ﾃ", "ﾞ"],
  "ド" => ["ﾄ", "ﾞ"],
  "バ" => ["ﾊ", "ﾞ"],
  "ビ" => ["ﾋ", "ﾞ"],
  "ブ" => ["ﾌ", "ﾞ"],
  "ベ" => ["ﾍ", "ﾞ"],
  "ボ" => ["ﾎ", "ﾞ"],
  "パ" => ["ﾊ", "ﾟ"],
  "ピ" => ["ﾋ", "ﾟ"],
  "プ" => ["ﾌ", "ﾟ"],
  "ペ" => ["ﾍ", "ﾟ"],
  "ポ" => ["ﾎ", "ﾟ"],
  "ー" => "-"
}

SHIBU = { 
  "10" => "北", "11" => "上京", "12" => "中京", "13" => "下京",
  "14" => "南", "15" => "左京", "16" => "東山", "17" => "山科",
  "18" => "右京", "19" => "西京", "20" => "伏見",
  "21" => "醍醐", "50" => "乙訓", "51" => "宇治", "53" => "亀岡",
  "54" => "船井", "56" => "綾部", "57" => "福知山", "58" => "舞鶴",
  "59" => "宮津", "60" => "奥丹後", "61" => "相楽", "62" => "洛南",
  "63" => "綴喜八幡",
  "85" => "法人", "90" => "表具", "95" => "電気",
}

SHIBU_VERSE = SHIBU.invert
SHIBU2 = { 
  "10" => "北", "11" => "上", "12" => "中", "13" => "下",
  "14" => "南", "15" => "左", "16" => "東", "17" => "山",
  "18" => "右", "19" => "西", "20" => "伏",
  "21" => "醍", "50" => "乙", "51" => "宇", "53" => "亀",
  "54" => "船", "56" => "綾", "57" => "福", "58" => "舞",
  "59" => "宮", "60" => "奥", "61" => "相", "62" => "洛",
  "63" => "綴",
  "85" => "法", "90" => "表", "95" => "電",
}
SHIBU2_VERSE = SHIBU2.invert

def to_zenkaku_fold(ary, ret)
  if ary.empty?
    ret
  else
    if ( ary.first == "ﾟ" ) or ( ary.first == "ﾞ" )
      to_zenkaku_fold(ary.slice(2..-1), ret.push(HAN[[ary[0], ary[1]]]))
    else
      to_zenkaku_fold(ary.slice(1..-1), ret.push(ary.first))
    end
  end
end

GENGOU = {
  "明治" => 1867, "明" => 1867, "M" => 1867, "m" => 1867,
  "大正" => 1911, "大" => 1911, "T" => 1911, "t" => 1911,
  "昭和" => 1925, "昭" => 1925, "S" => 1925, "s" => 1925,
  "平成" => 1988, "平" => 1988, "H" => 1988, "h" => 1988
}

def jdate2roman(gengou, year)
  return GENGOU[gengou] + year;
end


class String
  def string_to_date
    if self =~ /(\d{4})(\d{2})(\d{2})/
      (year, month, day) = $~.captures
      return Date::new(year.to_i, month.to_i, day.to_i);
    elsif self =~ /(\d{4})[-\/\.年][ 　]*(\d{1,2})[-\/\.月][ 　]*(\d{1,2})/
      (year, month, day) = $~.captures
      return Date::new(year.to_i, month.to_i, day.to_i);
    elsif self =~ /(明治|大正|昭和|平成)[ 　]*(\d{2})[-\/\.年][ 　]*(\d{1,2})[-\/\.月][ 　]*(\d{1,2})/
      (gengou, year, month, day) = $~.captures
      return Date::new(jdate2roman(gengou, year.to_i), month.to_i, day.to_i);
    elsif self =~ /([明大昭平MmTtSsHh])[ 　]*(\d{2})[-\/\.年][ 　]*(\d{1,2})[-\/\.月][ 　]*(\d{1,2})/
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
    self.gsub(/[ 　]*$/, "")
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

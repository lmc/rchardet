######################## BEGIN LICENSE BLOCK ########################
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 2.1 of the License, or (at your option) any later version.
# 
# This library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.
# 
# You should have received a copy of the GNU Lesser General Public
# License along with this library; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
# 02110-1301  USA
######################### END LICENSE BLOCK #########################

$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__))

require 'rchardet19/charsetprober'
require 'rchardet19/mbcharsetprober'

require 'rchardet19/big5freq'
require 'rchardet19/big5prober'
require 'rchardet19/chardistribution'
require 'rchardet19/charsetgroupprober'

require 'rchardet19/codingstatemachine'
require 'rchardet19/constants'
require 'rchardet19/escprober'
require 'rchardet19/escsm'
require 'rchardet19/eucjpprober'
require 'rchardet19/euckrfreq'
require 'rchardet19/euckrprober'
require 'rchardet19/euctwfreq'
require 'rchardet19/euctwprober'
require 'rchardet19/gb2312freq'
require 'rchardet19/gb2312prober'
require 'rchardet19/hebrewprober'
require 'rchardet19/jisfreq'
require 'rchardet19/jpcntx'
require 'rchardet19/langbulgarianmodel'
require 'rchardet19/langcyrillicmodel'
require 'rchardet19/langgreekmodel'
require 'rchardet19/langhebrewmodel'
require 'rchardet19/langhungarianmodel'
require 'rchardet19/langthaimodel'
require 'rchardet19/latin1prober'

require 'rchardet19/mbcsgroupprober'
require 'rchardet19/mbcssm'
require 'rchardet19/sbcharsetprober'
require 'rchardet19/sbcsgroupprober'
require 'rchardet19/sjisprober'
require 'rchardet19/universaldetector'
require 'rchardet19/utf8prober'

module CharDet19
  VERSION = "1.3"
  def self.detect(aBuf, options = {})
    if aBuf.nil?
      raise Exception.new("Sorry, we can't guess the encoding on a nil object") if not options[:silent]
      return self.create("", 0.0)
    end
    
    u = UniversalDetector.new
    u.reset
    u.feed( aBuf.dup ) #don't want to mutate source string
    u.close
    self.create(u.result['encoding'], u.result['confidence'])
  end
  
  def self.create(encoding, confidence)
    Struct.new(:encoding, :confidence).new(encoding, confidence)
  end
end
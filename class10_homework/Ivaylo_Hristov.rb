require'rexml/document'

def csys(parent, p1, p2, p3, p4)
	c = parent.add_element "polyline"
	c.attributes["points"] = "#{p1},#{p2} #{p3},#{p4}"
	c.attributes["stroke"] = "black"
	c.attributes["stroke-width"] = "2"
	c.attributes["fill"] = "black"
end

def linez(parent, p1, p2, p3, p4, cvqt, cvqt2, cvqt3)
	c = parent.add_element "polyline"
	c.attributes["points"] = "#{p1+600},#{350-p2} #{p3+600},#{350-p4}"
	c.attributes["stroke"] = "rgb(#{cvqt}, #{cvqt2}, #{cvqt3})"
	c.attributes["stroke-width"] = "2"	
end

if ARGV.length.even? and ARGV.length >= 2
	doc = REXML::Document.new
	el_svg = doc.add_element "svg"
	el_svg.attributes["version"] = "1.1"
	el_svg.attributes["xmlns"] = "http://www.w3.org/2000/svg"

	csys(el_svg, 600, 50, 600, 650)
	csys(el_svg, 300, 350, 900, 350)
	
        count = 0
        y1 = 0
        y2 = 0
        arg = ARGV[0]
        while arg != nil
    		ARGV[count] = ARGV[count].to_i
        	ARGV[count+1] = ARGV[count+1].to_i
        	
        	if ARGV[count] == 0
        		y1 = ARGV[count+1]
        		x1 = -300
        		y2 = ARGV[count+1]
        		x2 = 300
        	else
			[300, -300].each do |temp|
				x = (temp-ARGV[count+1])/ARGV[count]
				if x.between?(-300,300)
					y1 = temp
				end
			end
		
			[-300, 300].each do |temp|
				x = (temp-ARGV[count+1])/ARGV[count]
				if x.between?(-300,300)
					y2 = temp
				end
			end
			
        		x1=(y1-ARGV[count+1])/ARGV[count]
        		x2=(y2-ARGV[count+1])/ARGV[count]
		
		end
		
		linez(el_svg,x1,y1,x2,y2,rand(255),rand(255),rand(255))
		count+=2
		arg=ARGV[count+1]
        end

		
	
	File.open(__FILE__.gsub('.rb','.svg'), "w") do |f|
		f.write(doc.to_s)
	end
else
	p "Wrong number of Arguments"
end

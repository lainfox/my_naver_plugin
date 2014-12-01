# name: Naver video Onebox
# version: 0.1
# authors: Lainfox

# Naver URL 주소로는 outkey를 생성해야 해서 iframe 이 불가능. 
# iframe 내의 src 를 입력했을때 iframe 나오는 것만 함.
# <iframe src='http://serviceapi.rmcnmv.naver.com/flash/outKeyPlayer.nhn?vid=476FB10E64EE7A20C9046B03146A41CC951D&outKey=V12414d21883f4aff0538264feef201e046b6fecd5fe9d7b48a5b264feef201e046b6&controlBarMovable=true&jsCallable=true&isAutoPlay=true&skinName=tvcast_white' frameborder='no' scrolling='no' marginwidth='0' marginheight='0' WIDTH='544' HEIGHT='306'></iframe>

Onebox = Onebox

module Onebox
	module Engine
		class NaverVideoOnebox
			include Engine
			REGEX = /^https?:\/\/(?:serviceapi\.)?(?:rmcnmv\.)?(?:naver\.com\/flash\/outKeyPlayer.nhn?)\S*$/
			matches_regexp REGEX

			def to_html
				"<div class='naver-video'><iframe src='#{@url}'' width='640' height='360' frameborder='0' allowfullscreen></iframe><p>via <a href='#{@url}'>#{@url}</a></p></div>"
			end

		end
	end	
end

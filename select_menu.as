
#module select_menu
#deffunc msmenu int win_no, int x, int y//make_select_menu
win(a)=win_no : sbarx(a)=x : sbary(a)=y//windows_no, select_barx
mozi(a)=leter
gsel win(a)
sbarsx(a)=ginfo_winx : sbarsy(a)=ginfo_winy//��ʃT�C�Y��ۑ�
gsel 0//���̉�ʂɖ߂�
a+1
return

#deffunc smenufc int fc_r, int fc_g, int fc_b//select_menu_frame_color
	fcr=fc_r : fcg=fc_g : fcb=fc_b
	return

#deffunc ssmenu int key //show_select_menu
	gmode 0
	if key=0{
	getkey left,37
	getkey up,38
	getkey right,39
	getkey down,40
	getkey enter,13
	getkey esc,27
	}
	if up=0 & right=0 : upp=0//�������ϋ֎~
	if down=0 & left=0 : downp=0//�������ϋ֎~
	if (up=1 | right=1) & upp=0 & 0<b : b=b-1 : upp=1//��Ɉړ�
	if (down=1 | left=1) & downp=0 & b<a-1 : b=b+1 : downp=1//���Ɉړ�
	
	repeat a
		getkey lclick,1
		if sbarx(cnt)<=mousex & mousex<=sbarx(cnt)+sbarsx(cnt) & sbary(cnt)<=mousey & mousey<=sbary(cnt)+sbarsy(cnt){
			b=cnt
			if lclick=1 : lclickc=1//�����}�E�X�̈ʒu���{�^���O�������甽�����Ȃ��悤�ɂ���
		}
		if cnt=b{
			color fcr,fcg,fcb : boxf sbarx(cnt)-3,sbary(cnt)-3,sbarx(cnt)+sbarsx(cnt)+3,sbary(cnt)+sbarsy(cnt)+3
			pos sbarx(cnt),sbary(cnt) : celput win(cnt)
		}
		if cnt!b{
			pos sbarx(cnt),sbary(cnt) : celput win(cnt)
		}
	loop
	if enter=1 | lclickc=1 : kaesu=b
	if enter=0 & lclickc=0 : kaesu=-1
	if esc=1 : kaesu=-2
	lclickc=0
	;logmes kaesu
	
return kaesu

#deffunc smreset//slect_menu_resrt
repeat a
win(cnt)=0 : sbarx(cnt)=0 : sbary(cnt)=0//windows_no, select_barx
mozi(cnt)=""
loop
a=0 : b=0
return
#global

#module showing
#deffunc ensyutu int etype,int x, int y,int end_count
if end_count=0 : ii=60 : else : ii=end_count
gsel 0

if etype=0{//���񂾂�Â�����
	buffer 10001,ginfo_winx,ginfo_winy
	gsel 10001
	color 0,0,0 : boxf
	repeat 200
	gsel 0
	redraw 1 : redraw 0
	a++
	if a\3=0 : b=b+1
	gmode 3,,,b : pos 0,0 : celput 10001
	await 8
	loop
	}
if etype=1{//���񂾂񖾂邭����
	buffer 10001,ginfo_winx,ginfo_winy
	gsel 10001
	color 0,0,0 : boxf
	gsel 0
	gmode 4,,,255-cnt*2
	pos 0,0 : celput 10001
	gmode 0
	;await 8
	}
if etype=2{//�~�����܂��Ă����Ď~�܂��ċ��܂�
	buffer 10001,ginfo_winx*2,ginfo_winy*2
	setease 0,900,ease_quad_in
	i=0 : ii=100
	repeat 240
	redraw 1 : redraw 0
	gsel 10001
	i=i+1
	a=getease(i,ii)
	color 0,0,0 : boxf
	color 255,255,255 : circle x-990+a,y-990+a,x+1010-a,y+1010-a
	gsel 0
	if cnt=100 : setease 900,700,ease_quad_out : i=0 : ii=50
	if cnt=130 : setease 700,1000,ease_quad_in : i=0 : ii=40
	
	color 255,255,255 : gmode 4,,,255
	pos 0,0 : celput 10001
	await 10
	;logmes cnt
	loop
}
if etype=3{//�~���L����
	buffer 10001,ginfo_winx*2,ginfo_winy*2//��ʂ����
	if ginfo_winx/2>=ginfo_winy/2 : setease ginfo_winx/2,-(ginfo_winx/4),ease_quad_out//�傫���E�B���h�E�T�C�Y�ɍ��킹�����[�V����
	if ginfo_winy/2>ginfo_winx/2 : setease ginfo_winy/2,-(ginfo_winy/4),ease_quad_out
	if cnt=0 : i=0 : ii=60
		gsel 10001
	i=i+1
	a=getease(i,ii)
	color 0,0,0 : boxf
	color 255,255,255 : circle x-990+a,y-990+a,x+1010-a,y+1010-a
	gsel 0
	;color 200,100,0 : boxf
	color 255,255,255 : gmode 4,,,255
	pos 0,0 : celput 10001
}
return
#global
/*repeat //type1��test
redraw 1 : redraw 0
color 100,200,0 : boxf
ensyutu 1
await 16
loop*/
	;ensyutu 3,100,100
#module
////////////////�摜�T�C�Y��ς���//////////////
	#deffunc rspic int resize_win_no,double baixx ,double baiyy//resize_picture
			rwn=resize_win_no
			gsel rwn
			gx=ginfo_winx:gy=ginfo_winy//���̉摜�T�C�Y
			buffer 10002,baixx*gx,baiyy*gy//���̉摜���Z�{�����T�C�Y�ŐV������ʂ����
			gzoom ginfo_winx,ginfo_winy,rwn,0,0,gx,gy//���̉�ʂɌ��̉摜���Z�{�����̂𒣂�
			buffer rwn,baixx*gx,baiyy*gy//���ō�����摜������win_no�ɒ���t����
			celput 10002
		return
#global
#module
////////////�w�肵���摜�̐^�񒆂𒆐S�Ƃ��Ċ����Ŕz�u////////////////
	#deffunc ccppos int ccppos_win_no, int ccppos_percentx, int ccppos_percenty//cel_center_percent_position
		cwn=ccppos_win_no : cpx=ccppos_percentx : cpy=ccppos_percenty
		ga=ginfo_act//�������E�B���h�E
		if ga=-1 : ga=0
		gsel cwn//�摜�̑傫���𒲂ׂ�
		gx=ginfo_winx : gy=ginfo_winy
		gsel ga//�������E�B���h�E�ɖ߂�
		gx=gx/2 : gy=gy/2
		rgx=double(ginfo_winx*cpx/100) : rgy=double(ginfo_winy*cpy/100)//real_gx
		pos rgx-gx,rgy-gy
		return
#global
#module
	#defcfunc  ppos_x int ppos_percentx//��ʂ�percent�ł���킵����������x���W�����߂�//percent_positionx
		gx=double(ginfo_winx) : ppx=ppos_percentx
		return gx*ppx/100
	#defcfunc  ppos_y int ppos_percenty//��ʂ�percent�ł���킵����������x���W�����߂�//percent_positionx
		gy=double(ginfo_winy) : ppy=ppos_percenty
		return gy*ppy/100
#global
#module
	#defcfunc  ccppos_x int ccppos_win_no, int ccppos_percentx//��ʂ�percent�œ�����킵������x���W�����߂�//cel_center_percent_positionx
		ccwn=ccppos_win_no//���摜��ID
		ga=ginfo_act//�������E�B���h�E
		if ga=-1 : ga=0
		gsel ccwn//�摜�̑傫���𒲂ׂ�
		gx=ginfo_winx/2
		gsel ga//�������E�B���h�E�ɖ߂�
		rgx=double(ginfo_winx) : ccppx=ccppos_percentx//���̉�ʃT�C�Y�Ɠ\�肽���ʒu�̊�������
		return rgx*ccppx/100-gx//��
		
	#defcfunc  ccppos_y int ccppos_win_no, int ccppos_percenty//��ʂ�percent�œ�����킵������y���W�����߂�//cel_center_percent_positiony
		ccwn=ccppos_win_no//���摜��ID
		ga=ginfo_act//�������E�B���h�E
		if ga=-1 : ga=0
		gsel ccwn//�摜�̑傫���𒲂ׂ�
		gx=ginfo_winx/2
		gsel ga//�������E�B���h�E�ɖ߂�
		rgy=double(ginfo_winy) : ccppy=ccppos_percenty//���̉�ʃT�C�Y�Ɠ\�肽���ʒu�̊�������
		return rgy*ccppy/100-gx
#global

#module
#deffunc ggsquare int gm, int x1, int y1, int x2, int y2//�P�F��gmode�t���œh��Ԃ�
	a(0)=x1 : a(1)=x2 : a(2)=x2 : a(3)=x1 : b(0)=y1 : b(1)=y1 : b(2)=y2 : b(3)=y2
	gmode 3,,,gm
	gsquare -1,a,b
	return
#global

#module//�l�̌ܓ�(�����l�ɂ��ĕԂ�)
#defcfunc sisute5 var var1
	a=var1*10
	b=a\10
	if b<5 : c=int(var1)
	if b>=5 : c=int(var1)+1
	c=double(c)
	return c
#global

#module//�J��グ(�����l�ɂ��ĕԂ�)
#defcfunc kuriage double var1
	a=var1*10
	b=int(a)/10+1
	return b
#global

#module
#deffunc boxline int x1, int y1, int x2, int y2, int lthick//����
	boxf x1,y1 ,x2-lthick,y1+lthick : boxf x2-lthick,y1 ,x2,y2-lthick : boxf x2,y2 ,x1+lthick,y2-lthick : boxf x1,y2 ,x1+lthick,y1+lthick
	return
#global
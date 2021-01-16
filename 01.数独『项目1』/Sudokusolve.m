%1---------数独最终结题
function Sudokusolve()
while 1   %---------死循环开头
global kkk num11 ss B woo aa
woo=0;
%------题库导入
k111=xlsread('Sudoku.xls');
clc;
ButtonName=questdlg('你打算抽取的随机题目等级是？',...
    '(数独)等级选择','简单','疯狂','困难','简单');

%---1.———加载程序
steps=100;
hwait=waitbar(0,'请等待>>>>>>>>');
for k=1:steps
    if steps-k<=5
        waitbar(k/steps,hwait,'即将完成');
        pause(0.05);
    else
        str=['数独加载中',num2str(k),'%'];
        waitbar(k/steps,hwait,str);
        pause(0.05);
    end
end
close(hwait); 
%1.———加载程序

%2.
set(gcf,'color','b');
switch ButtonName
    case '简单'%-----------难度1，生成一个随机数1或2
        ff=randperm(2,1);%1-2简单
    case '疯狂'%-----------难度2，生成一个随机数1或2        
        ff=2+randperm(2,1);%3-4疯狂
    case '困难'%-----------难度3，生成一个随机数1或2或3       
        ff=4+randperm(3,1);%5-7困难
end
s111=k111((-8+ff*9):(-8+ff*9+8),:);
[a,b]=find(s111~=0);
B=[a,b];%---获得那个不为0的数的位置。(行列)
C=[];
[num1,num2]=size(B);%--获取数独的位置的行和列
for k222=1:num1
    C=[C;a(k222)*10+b(k222)];
end
cc=sort(C);
%--------排序，用来后面的求解
[num3,num4]=size(cc);
BB=[];
for k111=1:num3
    str1=num2str(cc(k111));
BB=[BB;str2num(str1(1)),str2num(str1(2))];
end
aa=(BB(1:num3,1));
bb=(BB(1:num3,2));
jj=[];
for nummmm=1:num3
    jj=[jj;s111(aa(nummmm,1),bb(nummmm,1))];
end
B=[aa,bb,jj];%生成的题目矩阵B
%-----------------------

axis off;
axis equal;
[aa,bb]=size(B);
for k2=1:aa
    num{B(k2,1),B(k2,2)}=B(k2,3);
end
%%%------------原始数据截止
ii=0;
kkk=[0,38,38,38,38,38,38,38,38];
num11=[0,37.5,37.5,37.5,37.5,37.5,37.5,37.5,37.5];
nnn=0;
for nn=1:9
    nnn=num11(nn)+nnn;
    for n=1:9
        ii=kkk(n)+ii;
        ss=num{n,nn};
        H=uicontrol('Style','edit','String',...
            ss,'FontSize',18,'Position',[(122+nnn) (351-ii) 37 37],...
            'BackgroundColor','w','Callback', @wheremap);
        pp=(get(H,'string'));
        if strcmp(pp,'')
        else
            set(H,'Style','text','BackgroundColor','y');
        end
    end
    ii=0;
end

uicontrol('Style','text','String',...
    '(数独)','FontSize',16,'Position',[252 393 80 28],...
    'BackgroundColor','c');
uicontrol('Style','pushbutton','String',...
    '完成（验证）','FontSize',18,'Position',[0 0 150 40],...
    'BackgroundColor','w','Callback',@button11);
uicontrol('Style','pushbutton','String',...
    '显示答案','FontSize',18,'Position',[410 0 150 40],...
    'BackgroundColor','w','Callback',@button22);

%-------------横着的黑色条（用黑色不可点击text框制作美化条）
uicontrol('Style','text',...
    'Position',[122 270 337 5 ],...
    'BackgroundColor','black');
uicontrol('Style','text',...
    'Position',[122 156 337 5 ],...
    'BackgroundColor','black');
%----------竖着的黑色条（用黑色不可点击text框制作美化条）
uicontrol('Style','text',...
    'Position',[234 47 5 340 ],...
    'BackgroundColor','black');
uicontrol('Style','text',...
    'Position',[346 47 5 340 ],...
    'BackgroundColor','black');
%--------------------------
hold on
rectangle('Position',[0 0 9 9],...
    'LineWidth',6,'EdgeColor','r','Clipping','off');
ss=sudokuEngine(B);%%%画ss会有奇怪的东西
helpdlg('你可以看题目30s','提示框');
pp=30;%5miao
%-----------游戏倒计时系统
nowt=num2cell(fix(clock));
addt=cell(1,6);
addt={0,0,0,0,0,0 };
addt{1,6}=pp;
%输入时间
a=cell2mat(nowt);
b=cell2mat(addt);
count=a+b;
% %设置时间到关闭H
% H=gcf;
global Endtime 
Endtime=[count];
t=timer('StartDelay', 0,'Period',0.05,...
    'TasksToExecute', 10000,...
    'ExecutionMode','fixedRate');
t.TimerFcn={@timed}; %% function函数
start(t);
%%%%-------------倒计时
% sss=num2cell(ss);%yuanbao
% disp(things);%%%%%弄出来的一个东西
pause(631);%------多1秒
%-----------
ButtonN=questdlg('是否重新游戏？','选择','是','取消（退出游戏）','是');
switch ButtonN
    case '是'
        close(figure(1)); 
    otherwise
        break;    
end   %---
end  %-------死循环结尾
close(figure(1));
clc;
clear;
end   % 主函数的结尾end!!

%子函数1 %-获取被点击的格子的位置，并且提供判断正确的依据
function wheremap(hObj,event)
% global things
as=get(hObj,'Position');  %as 是数组！！
%求被点击的格子的位置
num1=as(1);%lie
num2=as(2);%han
kkk=[0,38,38,38,38,38,38,38,38];
num11=[0,37.5,37.5,37.5,37.5,37.5,37.5,37.5,37.5];
nnn=0;
ii=0;
for lie=1:9
    nnn=num11(lie)+nnn;
    for han=1:9
        ii=kkk(han)+ii;
        if 122+nnn==num1&&351-ii==num2
            num10=han;
            num20=lie;
        end
    end
    ii=0;
end
%以上为求格子的位置！！！% [aaa,bbb]=size(things);% disp(aaa);% disp(bbb);% disp(id);
global ss woo
val=get(hObj,'string');
kk=str2num(val);
if kk==ss(num10,num20)
woo=1+woo;
end
if woo>=60&&kk==ss(num10,num20)
    helpdlg('答对了（恭喜你）','提示框');
else    
if kk~=ss(num10,num20)
    helpdlg('这个地方好像不能填这个（可以检查一下哦）',...
        '提示框');
else
    set(hObj,'string',val);
end
end
end

%%子函数2  按钮1
function button11(hObj,event)
%把aa传过来，好让我们确定，我们需要答对多少就可以对
global woo aa
% if woo>=60
if woo>=(81-aa)
    helpdlg('答对了（恭喜你）','提示框');
else
    helpdlg('可以检查一下哦','提示框');
end
end


%%子函数3  按钮2
function button22(hObj,event)
global B
jj=sudokuEngine(B);
yy=[];
for ii=1:9
    for j=1:9
     kk=[ii,j,jj(ii,j)];
     yy=[kk;yy];
    end
end
% disp(yy);
[aa,bb]=size(yy);
for k2=1:aa
    num{yy(k2,1),yy(k2,2)}=yy(k2,3);
end
ii=0;
kkk=[0,38,38,38,38,38,38,38,38];
num11=[0,37.5,37.5,37.5,37.5,37.5,37.5,37.5,37.5];
nnn=0;
for nn=1:9
    nnn=num11(nn)+nnn;
    for n=1:9
        ii=kkk(n)+ii;
        ss=num{n,nn};
        H=uicontrol('Style','edit','String',...
            ss,'FontSize',18,'Position',[(122+nnn) (351-ii) 37 37],...
            'BackgroundColor','w','Callback', @wheremap);
        pp=(get(H,'string'));
        if strcmp(pp,'')
        else
            set(H,'BackgroundColor','y');
        end
    end
    ii=0;
end
clc;
end
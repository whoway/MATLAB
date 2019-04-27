%2-------倒计时函数！！！
function timed(t,events,arg_str)
global Endtime 
Lefttime=etime(Endtime,clock);
if Lefttime<0
    stop(t);
    cc=gcf; 
ButtonName=questdlg('题目阅读时间到了哦!',...
    '时间提示框','太难了（这盘我不玩了）','开始游戏吧','太难了（这盘我不玩了）');
switch ButtonName
    case '开始游戏吧'
        helpdlg('欢迎正式答题!(现在你有10分钟游戏时间)','欢迎框');
    otherwise
         close(cc);
end
    return
end
H=uicontrol('Style','text','String',...
    'ss','FontSize',14,'Position',[13 376 90 43],...
    'BackgroundColor','g');
LeftSeconds=floor(rem(Lefttime,60));
LeftMinutes=floor(rem(Lefttime/60,60));
r=sprintf('剩余时间:\n%d分%d秒',LeftMinutes,LeftSeconds);
set(H,'string',r);
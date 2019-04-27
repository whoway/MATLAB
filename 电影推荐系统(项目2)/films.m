%----2.获取推荐，调用相似度(主函数)
function films=films(id)
    %获取前五名相似度矩阵（调用子函数1）
    simvalueuserId=get_similarity(id);
    base=load('ratings.data');
    %读取电影数据
    items=importdata('movies.data','|',0);
    %先定义好推荐电影的空集
    films=[];
    %前5名相似度遍历电影
    for n=1:5
        %获取最相似用户的评分矩阵
        first_base = base(base(:,1)==simvalueuserId(n,2),:);
        %获取此用户评价为5分的最高的电影评分矩阵
        first_base_top = first_base(find(first_base(:,3)==5),:);
        %获取电影名
        films_items=items.textdata(first_base_top(:,2),2);
        %追加电影名到先前定义好的空集中
        films=[films;films_items];
    end
    %unique去重，防止5个最相似用户推荐的电影有重复
    films=unique(films);
end

%------子函数1----相似度计算
function simvalueuserId=get_similarity( id )
    %读取makedata弄出的评分矩阵
    load('rating');
    %通过输入的id弄出该用户对各电影的评分向量（未评分为0）
    oneLine=getOneLine(id);
    %将测试用户的评分向量追加到rating末尾
    rating=[rating;oneLine];
    %转置（因为corrcoef算的是列的相似度）
    rating=rating';
    %获得各列之间的皮尔逊相似度
    corr=corrcoef(rating);
    %获取行列，都等于用户数
    [corr_line,corr_row] = size(corr);
    %获取最后一列的相似度，就是输入的id用户的与各个用户的相似度
    similarity = corr(:,corr_row);
    %去除与自身的相似度
    similarity(corr_line)=[];
    %--- 得到前5的相似度值，用户id矩阵
    [sim_v sim_i]=sort(similarity,1,'descend');
    simvalueuserId=[sim_v(1:5),sim_i(1:5)];     
end

%------子函数2
function [oneLine]=getOneLine( id )
%通过用户的ID获取对各个电影的评分的0向量
%读取测试集（用户ID，电影id，评分，时间戳）
test=load('ratings.data');
%去除时间戳
test=test(:,1:3);
%查找到输入用户的id的对电影的所有评分，用户id，电影ID，评分的矩阵
oneTest=test(test(:,1)==id,:);
%直接读取info给的电影数
info=textread('u.info','%n%*[^\n]');%使用正则表达式
oneLine=zeros(1,info(2));
%------ 给电影向量赋值
[oneTestNum,v] = size(oneTest);
for n=1:oneTestNum
    oneTestLine = oneTest(n,:);
    oneLine(oneTestLine(2)) = oneTestLine(3);
end
end
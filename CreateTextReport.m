function [Data]=CreateTextReport(Data);

Data.ReportName=['PCA REPORT ' Data.file ];
[Data.Reportfile,Data.Reportpath,Data.Reportindx] = uiputfile('*.txt','File Selection', Data.ReportName);
Data.ReportFilename = fullfile(Data.Reportpath,Data.Reportfile);


if Data.Reportfile==0;
        clc
else
%%
    fileID = fopen( Data.ReportFilename, 'wt' );
%%    
    line{1} = 'PRINCIPAL COMPONENT ANALYSIS REPORT\n\r';
    line{2}='\r';
    c=date;
    line{3}=['Report Date  ==>   ' c '\r'];
    line{4}=['File Name    ==>   ' Data.file '\r'] ;
    string1=num2str(size(Data.colheaders,2));
    line{5}=['Number of Variables   ==>   ' string1 '\r'] ;

    string2=(Data.Method);
    line{6}=['PCA performed using   ==>   ' string2 '\r'] ;

    a = (size(line,2));
    b = size(Data.colheaders,2);
    for i=1:b
        switch i
            case i==1
                line{a+i}= ['\rVariable Names ==>  ' char(Data.colheaders(i)) '\r'];
            otherwise 
                line{a+i}= ['                    ' char(Data.colheaders(i)) '\r'];
        end
    end
    clear string1 string2 a b c

    for i=1:size(line,2)
        fprintf(fileID, line{i});
    end

    %% Variance
    title='\rVariance Explained by each Components\r' ;
    fprintf(fileID,title);
    t='';
    for i=1:size(Data.latent,2)
        t=[t ' %f'];
    end
    t=[t '\n'];
    fprintf(fileID,t, Data.latent);
    clear t title

    %% Component Coefficients
    title='Component Coefficients\r';
    fprintf(fileID, ['\r' title]);
    t='';
    [a b]= size(Data.coeff);
    for i=1:b
           t=[t ' %f'];
    end
    t=[t '\n'];
    fprintf(fileID,t, Data.coeff');
    clear t title a b

    %% Selected number of Components
    title='Selected number of Component Coefficients ==>  ';
    string1=num2str(Data.NumberCompSelected);
    fprintf(fileID,['\r' title (string1) '\r']);
    clear string1 title
 %% Explained variance by selected components
    x=Data.NumberCompSelected;
    y=Data.latentS(x);
    title = ['With ',num2str(x),' Components ' ,num2str(y) ,' percent of variance is explained'];
    fprintf(fileID,['\r' title  '\r']);
    clear x y title
    
    %% Selected Component Coefficients
    title='Selected Component Coefficients\r';
    fprintf(fileID, ['\r' title]);
    t='';
    [a b]= size(Data.SelectedCompsCoeff);
    for i=1:b
           t=[t ' %f'];
    end
    t=[t '\n'];
    fprintf(fileID,t, Data.SelectedCompsCoeff');
    clear t title a b
    
        %%  Component Scores
    title='Component Scores\r';
    fprintf(fileID, ['\r' title]);
    t='';
    [a b]= size(Data.score);
    for i=1:b
           t=[t ' %f'];
    end
    t=[t '\n'];
    fprintf(fileID,t, Data.score');
    clear t title a b

   
    %==============
    fclose(fileID);
    clear line
    %%
    msgbox('Your Report is created');

end
% n=Data.ReportResponse;
% save (char(n), 'Data');
end


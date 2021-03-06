function [ emo ] = classify_emo( testfile )
%This function takes features of a file(files) as input in form of a matrix
%and returns corresponding emotion

        
       cd Emo_features_60
    features_sv_a=dlmread('emo_a.dat');
    features_sv_f=dlmread('emo_f.dat');
    features_sv_n=dlmread('emo_n.dat');
    features_sv_w=dlmread('emo_w.dat');
    features_sv_l=dlmread('emo_l.dat');
    features_sv_t=dlmread('emo_t.dat');
    features_sv_e=dlmread('emo_e.dat');
    
    cd ..
    
    %STORE LENGTHS OF EACH TYPE OF FEATURE
    len_fea(1)=size(features_sv_a,1);
    len_fea(2)=size(features_sv_f,1);
    len_fea(3)=size(features_sv_n,1);
    len_fea(4)=size(features_sv_w,1);
    len_fea(5)=size(features_sv_e,1);
    len_fea(6)=size(features_sv_t,1);
    len_fea(7)=size(features_sv_l,1);
    
    n=7;
    max_len=max(len_fea);
    emo_features=zeros(max_len,60,n);
    
    %ICORPORATE ALL FEATURES IN A 3-D ARRAY
    emo_features(1:len_fea(1),:,1)=features_sv_a;
    emo_features(1:len_fea(2),:,2)=features_sv_f;
    emo_features(1:len_fea(3),:,3)=features_sv_n;
    emo_features(1:len_fea(4),:,4)=features_sv_w;
    emo_features(1:len_fea(5),:,5)=features_sv_e;
    emo_features(1:len_fea(6),:,6)=features_sv_t;
    emo_features(1:len_fea(7),:,7)=features_sv_l;
    
    
    
    group=ones(max_len,n);
    for i=[1:n]
        group(:,i)=group(:,i)*i;
    end
               
             %-----------------------------------------------------------------%
            %CREATE SVM STRUCTS AFTER TRAINING


            k=1;
            for i=[1:n-1]
                for j=[i+1:n]
                    svm(k)=svmtrain(  [emo_features( 1:50,:,i);emo_features(1:50,:,j)]  , [group(1:50,i);group(1:50,j)]  );
                    k=k+1;
                end
            end
            k=k-1;

             %-----------------------------------------------------------------%
            %CLASSIFY TEST DATA
            
                for j=[1:k]
                    label(j)=svmclassify( svm(j),test );
                end
            
            emo=mode( label);
        
end


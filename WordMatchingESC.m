function WordMatchingESC(option,dataset,featureFunc,nomalizeFunc,heightMatter,technique)
switch (option)
    case 'generateFeatureMat'
        % Select the folder containing the reference images
        dirOutput = '/Users/tanmoymondal/Documents/Study Guru/STUDY GURU/Dataset/reference Img/Ref Img_CSER/RefSet_1/';
        if(strcmp(dataset,'CSER'))
            files = dir(fullfile(dirOutput, '*.jpg'));
        end
        fileNamesRef = {files.name}';
        imgPathRef = strcat(dirOutput,'/');
        nImagesRef = (length(fileNamesRef));
        
        if(strcmp(dataset,'CSER'))
            % The directory containing the folders which is having the full images
            dirOutputSourceImgFolders = '/Volumes/Macintosh_HD_2/Word Spotting Dataset/Dataset_CESR/ClusteredComponentImg/componentImg_1';
            filesSource = dir(dirOutputSourceImgFolders);
            isDir = [filesSource.isdir];
            dirNames = {filesSource(isDir).name};
        end
        
        for goEachRefImg = 1:1:nImagesRef
            imageFilePathRef = [imgPathRef,fileNamesRef{goEachRefImg}];
            [~, refName, ~] = fileparts(imageFilePathRef);
            
            entered = 0;
            if(strcmp(dataset,'CSER'))
                for matchImgDir = 1:1:(size(dirNames,2))
                    myFolder = dirNames{1,matchImgDir}; % getting all the folders in the particular directory
                    if(strcmp(refName,myFolder)) % if there are any folder matched with reference name
                        entered = 1;
                        eachFolderPath = [dirOutputSourceImgFolders '/' myFolder '/'];
                        filesInFolder = dir(fullfile(eachFolderPath, '*.jpg'));
                        fileNamesInFolder = {filesInFolder.name}';
                        break;
                    end
                end
                if(entered == 1)
                    disp(refName);
                    keepAllFeature = generateFeaturemat(eachFolderPath,fileNamesInFolder,nomalizeFunc,featureFunc,heightMatter);
                    varName = [refName '_' featureFunc '_' heightMatter '_' nomalizeFunc];
                    disp(varName);
                    save(varName,'keepAllFeature');
                end
            end
        end
        % Generating the feature mat for the new dataset
    case 'generateFeatureMatNewDataset'
        
        noOfNoise = 100;
        % Select the folder containing the reference images
        refImag{1,1} = 'cheualerie';
        refImag{1,2} = 'cheual';
        refImag{1,3} = 'cheualier';
        refImag{1,4} = 'cheualier';
        refImag{1,5} = 'cheuallier';
        refImag{1,6} = 'cheuaus';
        refImag{1,7} = 'cheuaux';
        
        refImag{2,1} = 'cognoistre';
        refImag{2,2} = 'cognoitre';
        refImag{2,3} = 'connoistre';
        refImag{2,4} = 'connoitre';
        refImag{2,5} = 'reconoitre';
        refImag{2,6} = 'recognoistre';
        refImag{2,7} = 'reconnoistre';
        refImag{2,8} = 'reconnoitre';
        
        refImag{3,1} = 'royaume';
        refImag{3,2} = 'royales';
        refImag{3,3} = 'royau';
        refImag{3,4} = 'royaumes';
        refImag{3,5} = 'royaus';
        refImag{3,6} = 'royaute';
        refImag{3,7} = 'royaux';
        refImag{3,8} = 'royne';
        refImag{3,9} = 'roys';
        refImag{3,10} = 'rois';
        refImag{3,11} =  'roy';
        
        refImag{4,1} = 'immortel';
        refImag{4,2} = 'immortales';
        refImag{4,3} = 'immortali';
        refImag{4,4} = 'immortalit';
        refImag{4,5} = 'mortel';
        refImag{4,6} = 'immortelle';
        refImag{4,7} = 'immortels';
        
        
        %*************************************************************************
        % this poriotnn of the code was created for generating some noise in
        % the ESC dataset. eachNoisePortion given the nmber of noisy elements
        % to be put inside each folder
        
        %         eachNoisePortion = noOfNoise/size(refImag,1);
        %         dirOutput = '/Volumes/Macintosh_HD_2/Word Spotting Dataset/Dataset_CESR/Grouped_Images_3/Binary_4/';
        %         for ui = 1:1:size(refImag,1)
        %             for yyu = 1:1:size(refImag,2)
        %                 if(~isempty(refImag{ui,yyu}))
        %                     refFolPath =[dirOutput refImag{ui,yyu} '/' 'AllComponentImagesGrey/'];
        %                     imageFilePath = ['/Volumes/Macintosh_HD_2/Word Spotting Dataset/Next Collection/ESC-TEST/',refImag{ui,yyu}];
        %                     filesInFolder = dir(fullfile(refFolPath, '*.jpg'));
        %                     fileNamesInFolder = {filesInFolder.name}';
        %                     totImg = length(fileNamesInFolder);
        %                     b = randperm(totImg,eachNoisePortion);
        %
        %                     for tty = 1:1: eachNoisePortion
        %                         imgNm  = fileNamesInFolder{b(1,tty),1};
        %                         imComPath = [refFolPath imgNm];
        %                         img = imread(imComPath);
        %                         [~,myGtImgName,~] = fileparts(imComPath);
        %                         savingPath = [imageFilePath, '/',myGtImgName,'.jpg'];
        %                         imwrite(img,savingPath);
        %                     end
        %                 end
        %             end
        %         end
        %**************************************************************************
        
        
        myImpRef = cell(1,2);
        myImpRefCnt = 1;
        for ui = 1:1:size(refImag,1)
            
            for yyu = 1:1:size(refImag,2)
                if(~isempty(refImag{ui,yyu}))
                    myImpRef{myImpRefCnt,1} = refImag{ui,yyu};
                    GtCorrsRefImgStorer = GTImgFinder(refImag{ui,yyu},featureFunc,nomalizeFunc,heightMatter);
                    myImpRef{myImpRefCnt,2} = GtCorrsRefImgStorer;
                    myImpRefCnt = myImpRefCnt +1;
                end
            end
        end
        varName = ['NewDatasetCESR-ESC' '_' featureFunc '_' heightMatter '_' nomalizeFunc];
        disp(varName);
        save(varName,'myImpRef');
        
        
        
        % this part is for generating dataset for ESC algorithm
        % *************************************************************************
        %         for ui = 1:1:length(myImpRef)
        %             refImgNm = myImpRef{ui,1};
        %             imageFilePath = ['/Volumes/Macintosh_HD_2/Word Spotting Dataset/Next Collection/ESC-TEST/',refImgNm];
        %             if((exist(imageFilePath,'dir'))==0)
        %                 mkdir(imageFilePath);
        %             end
        %             for iuti = 1:1:size((myImpRef{ui,2}{1,2}),1)
        %                 gtImgNm = myImpRef{ui,2}{1,2}{iuti,1};
        %                 img = imread(gtImgNm);
        %                 [~,myGtImgName,~] = fileparts(gtImgNm);
        %                 savingPath = [imageFilePath, '/',myGtImgName,'.jpg'];
        %                 imwrite(img,savingPath);
        %             end
        %         end
        % *************************************************************************
        
    case 'matchOfflineNewCSER'
        % Select the folder containing the reference images        refImag{1,1} = 'cheualerie';
        refImag{1,1} = 'cheualerie';
        refImag{1,2} = 'cheual';
        refImag{1,3} = 'cheualier';
        refImag{1,4} = 'cheuallier';
        refImag{1,5} = 'cheuaus';
        refImag{1,6} = 'cheuaux';
        
        refImag{2,1} = 'cognoistre';
        refImag{2,2} = 'cognoitre';
        refImag{2,3} = 'connoistre';
        refImag{2,4} = 'connoitre';
        refImag{2,5} = 'reconoitre';
        refImag{2,6} = 'recognoistre';
        refImag{2,7} = 'reconnoistre';
        refImag{2,8} = 'reconnoitre';
        
        refImag{3,1} = 'royaume';
        refImag{3,2} = 'royales';
        refImag{3,3} = 'royau';
        refImag{3,4} = 'royaumes';
        refImag{3,5} = 'royaus';
        refImag{3,6} = 'royaute';
        refImag{3,7} = 'royaux';
        refImag{3,8} = 'royne';
        refImag{3,9} = 'roys';
        refImag{3,10} = 'rois';
        refImag{3,11} =  'roy';
        
        refImag{4,1} = 'immortel';
        refImag{4,2} = 'immortales';
        refImag{4,3} = 'immortali';
        refImag{4,4} = 'immortalit';
        refImag{4,5} = 'mortel';
        refImag{4,6} = 'immortelle';
        refImag{4,7} = 'immortels';
        
        refImag{5,1} = 'cheuaus'; 
        refImag{5,2} = 'cheual';
        refImag{5,3} = 'cheualier';
        refImag{5,4} = 'cheuallier';
        refImag{5,5} = 'cheualerie';
        refImag{5,6} = 'cheuaux';
        
        refImag{6,1} = 'cheuaux';
        refImag{6,2} = 'cheual';
        refImag{6,3} = 'cheualier';
        refImag{6,4} = 'cheuallier';
        refImag{6,5} = 'cheualerie';
        refImag{6,6} = 'cheuaus';
        
        refImag{7,1} = 'cheualerie'; 
        refImag{7,2} = 'cheual';
        refImag{7,3} = 'cheualier';
        refImag{7,4} = 'cheuallier';
        refImag{7,5} = 'cheuaux';
        refImag{7,6} = 'cheuaus';
        
        refImag{8,1} = 'cognoitre'; 
        refImag{8,2} = 'cognoistre';
        refImag{8,3} = 'connoistre';
        refImag{8,4} = 'connoitre';
        refImag{8,5} = 'reconoitre';
        refImag{8,6} = 'recognoistre';
        refImag{8,7} = 'reconnoistre';
        refImag{8,8} = 'reconnoitre';
        
        refImag{9,1} = 'connoistre';  
        refImag{9,2} = 'cognoistre';
        refImag{9,3} = 'cognoitre';
        refImag{9,4} = 'connoitre';
        refImag{9,5} = 'reconoitre';
        refImag{9,6} = 'recognoistre';
        refImag{9,7} = 'reconnoistre';
        refImag{9,8} = 'reconnoitre';
        
        refImag{10,1} = 'recognoistre';  
        refImag{10,2} = 'cognoistre';
        refImag{10,3} = 'cognoitre';
        refImag{10,4} = 'connoitre';
        refImag{10,5} = 'reconoitre';
        refImag{10,6} = 'connoistre';
        refImag{10,7} = 'reconnoistre';
        refImag{10,8} = 'reconnoitre';
        
        refImag{11,1} = 'immortali';
        refImag{11,2} = 'immortales';
        refImag{11,3} = 'immortel';
        refImag{11,4} = 'immortalit';
        refImag{11,5} = 'mortel';
        refImag{11,6} = 'immortelle';
        refImag{11,7} = 'immortels';
        
        refImag{12,1} = 'mortel';
        refImag{12,2} = 'immortales';
        refImag{12,3} = 'immortel';
        refImag{12,4} = 'immortalit';
        refImag{12,5} = 'immortali';
        refImag{12,6} = 'immortelle';
        refImag{12,7} = 'immortels';
        
        
        refImgIndicator{1,1} = 'cheualerie';
        refImgIndicator{1,2} = 1;
        
        refImgIndicator{2,1} = 'cognoistre';
        refImgIndicator{2,2} = 1;
        
        refImgIndicator{3,1} = 'royaume';
        refImgIndicator{3,2} = 2;
        
        refImgIndicator{4,1} = 'immortel';
        refImgIndicator{4,2} = 1;
        
        
        
        refImgIndicator{5,1} = 'cheuaus';
        refImgIndicator{5,2} = 1;
        
        refImgIndicator{6,1} = 'cheuaux';
        refImgIndicator{6,2} = 1;
        
        refImgIndicator{7,1} = 'cheualerie';
        refImgIndicator{7,2} = 1;
        
        refImgIndicator{8,1} = 'cognoitre';
        refImgIndicator{8,2} = 1;
        
        refImgIndicator{9,1} = 'connoistre';
        refImgIndicator{9,2} = 1;
        
        
        
        refImgIndicator{10,1} = 'recognoistre';
        refImgIndicator{10,2} = 1;
        
        refImgIndicator{11,1} = 'immortali';
        refImgIndicator{11,2} = 1;
        
        refImgIndicator{12,1} = 'mortel';
        refImgIndicator{12,2} = 1;
        
        
        
        
        % Select the folder containing the reference images
        refImgSaver = '/Volumes/Macintosh_HD_2/Word Spotting Dataset/Dataset_CESR/Grouped_Images_3/allRefImages';
        
        %         load('NewDatasetCESR_columnFeature_makeDoubleHeight_Old_Normalize.mat');
        load('NewDatasetCESR-ESC_columnFeature_makeDoubleHeight_Old_Normalize.mat');
        for ii = 1:1:size(refImag,1)
            if(~isempty(refImag{ii,1}))
                refImgNm = refImag{ii,1};
                % now search the reference image name in all the array
                for searchRef = 1:1:length(myImpRef)
                    tempImgNm = myImpRef{searchRef,1};
                    if(strcmp(tempImgNm,refImgNm))
                        noTotRefImgPossible = size( (myImpRef{searchRef,2}{1,2}),1 );
                        refSaveFolder  = [refImgSaver '/' refImgNm '/'];
                        if((exist(refSaveFolder,'dir'))==0)
                            mkdir(refSaveFolder);
                        end
                        for iui = 1:1:noTotRefImgPossible
                            imgPath = myImpRef{searchRef,2}{1,2}{iui,1};
                            getImg = imread(imgPath);
                            imwrite(getImg,[refSaveFolder num2str(iui) '.jpg']);
                        end
                        % select any random index
                        if(strcmp(tempImgNm,refImgIndicator{ii,1}))
                            randIndex = refImgIndicator{ii,2};%randi([1, noTotRefImgPossible]);
                        else
                            error('Some problem in refImgIndicator');
                        end
                        imageFilePathRef = myImpRef{searchRef,2}{1,2}{randIndex,1};
                        [~, refName, ~] = fileparts(imageFilePathRef);
                        refImg = imread(imageFilePathRef);
                        break;
                    end
                end
            end
            featureSaver = cell(1,1);
            totGTSaver = cell(1,1);
            featureMatCnt = 1;
            for uuy = 1:1:size(refImag,2)
                refImgNm = refImag{ii,uuy};
                % now search the reference image name in all the array for the feature values
                if(~isempty(refImag{ii,uuy}))
                    for searchRef = 1:1:length(myImpRef)
                        tempImgNm = myImpRef{searchRef,1};
                        if(strcmp(tempImgNm,refImgNm))
                            featureSaver{featureMatCnt,1} = myImpRef{searchRef,2}{1,3};
                            totGTSaver{featureMatCnt,1} = myImpRef{searchRef,2}{1,2};
                            featureMatCnt = featureMatCnt +1;
                            break;
                        end
                    end
                end
            end
            % Merging all the features in one matrix
            mergedFeatureMat = cell(1,1);
            mergedFeautureCnt = 1;
            
            mergedGTArr= cell(4,1);
            mergedGTCnt = 1;
            for io = 1:1:length(featureSaver)
                for tt = 1:1:length(featureSaver{io,1})
                    mergedFeatureMat{mergedFeautureCnt,1} = featureSaver{io,1}{tt,1};
                    mergedFeatureMat{mergedFeautureCnt,2} = featureSaver{io,1}{tt,2};
                    mergedFeatureMat{mergedFeautureCnt,3} = featureSaver{io,1}{tt,3};
                    mergedFeatureMat{mergedFeautureCnt,4} = featureSaver{io,1}{tt,4};
                    mergedFeautureCnt = mergedFeautureCnt +1;
                end
                for tk = 1:1:size(totGTSaver{io,1},1)
                    mergedGTArr{1,mergedGTCnt} = totGTSaver{io,1}{tk,1};
                    mergedGTArr{4,mergedGTCnt} = totGTSaver{io,1}{tk,2};
                    mergedGTCnt = mergedGTCnt +1;
                end
            end
            resultArr = matchFeatureOfflineForNewCSER(mergedFeatureMat,refName,refImg,technique,nomalizeFunc,featureFunc,heightMatter,mergedGTArr);
            allAccuracyArr{ii,1} =  resultArr;
        end
        
        varName = [technique '_' nomalizeFunc '_' featureFunc '_ESC_v1_' heightMatter];
        disp(varName)
        save(varName,'allAccuracyArr');
end

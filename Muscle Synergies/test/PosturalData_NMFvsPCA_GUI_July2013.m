function varargout = PosturalData_NMFvsPCA_GUI_July2013(varargin)
% POSTURALDATA_NMFVSPCA_GUI_JULY2013 M-file for PosturalData_NMFvsPCA_GUI_July2013.fig
%      POSTURALDATA_NMFVSPCA_GUI_JULY2013, by itself, creates a new POSTURALDATA_NMFVSPCA_GUI_JULY2013 or raises the existing
%      singleton*.
%
%      H = POSTURALDATA_NMFVSPCA_GUI_JULY2013 returns the handle to a new POSTURALDATA_NMFVSPCA_GUI_JULY2013 or the handle to
%      the existing singleton*.
%
%      POSTURALDATA_NMFVSPCA_GUI_JULY2013('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in POSTURALDATA_NMFVSPCA_GUI_JULY2013.M with the given input arguments.
%
%      POSTURALDATA_NMFVSPCA_GUI_JULY2013('Property','Value',...) creates a new POSTURALDATA_NMFVSPCA_GUI_JULY2013 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PosturalData_NMFvsPCA_GUI_July2013_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PosturalData_NMFvsPCA_GUI_July2013_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PosturalData_NMFvsPCA_GUI_July2013

% Last Modified by GUIDE v2.5 02-Jul-2013 13:46:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PosturalData_NMFvsPCA_GUI_July2013_OpeningFcn, ...
                   'gui_OutputFcn',  @PosturalData_NMFvsPCA_GUI_July2013_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before PosturalData_NMFvsPCA_GUI_July2013 is made visible.
function PosturalData_NMFvsPCA_GUI_July2013_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PosturalData_NMFvsPCA_GUI_July2013 (see VARARGIN)

% Choose default command line output for PosturalData_NMFvsPCA_GUI_July2013
handles.output = hObject;

set(hObject,'toolbar','figure');
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes PosturalData_NMFvsPCA_GUI_July2013 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = PosturalData_NMFvsPCA_GUI_July2013_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%***********************************************
% Various initializations & declarations       *
%***********************************************


%***********************************************
% Load and Plot the original Data              *
%***********************************************

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global DATAsrc DATA_LST checkwalk time nmus ncond ntrials nbins color

%                  1          2          3          4          5          6          7        8           9        10            11        12
%                red     fade red     green    fade green    blue     fade blue   black     gray       yellow    orange        plum      lime
color_palette= [255 0 0; 255 150 150; 0 114 54; 153 255 102; 0 0 255; 44 176 207; 0 0 0; 155 155 155; 255 153 0; 255 185 0; 153 51 102; 171 218 77]*(1/255);
color=color_palette([6 1 2 10 11 4 3 5 12 7 8 9 1 10 4 6 11 3 2 5 12],:); %S0052 functional vars (EMGGRFandCOM file)


% Load the data
checkwalk=get(handles.checkbox_walking,'Value');

if checkwalk==1;
    load example_walking_data DATAsrc DATA_LST time %eventually modify this to allow user to select a file
else
    load example_postural_data DATAsrc DATA_LST
    nmus=16; ncond=12; ntrials=5; nbins=4;
    
%     load PDP05P0M_EMG_data_only_begin150ms_nobkg_scaledtowalking DATAsrc DATA_LST
%     DATAsrc(14:16,:)=[];
%     DATA_LST(:,1:4)=[];
%     DATA_LST(14:16,:)=[];
%     nmus=13; ncond=12; ntrials=3; nbins=3;
end



%***********************************************
% Plotting the dataset (tuning curves)         *
%***********************************************

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global DATAsrc DATA_LST checkwalk time nmus ncond ntrials nbins

if checkwalk==0
% Plot the data (tuning curves)
Data=reshape(DATAsrc',[ntrials ncond nbins nmus]);
elseif checkwalk==1
    Data=DATAsrc;
    nmus=size(DATAsrc,1);
end

figure
for i=1:nmus
    if checkwalk==0 %Plot tuning curves for postural data
        %for k=1:nbins %to plot all 4 time bins
        for k=3:3 %to plot only one time bin
            %subplot(nmus,nbins,((nbins)*i)-(nbins-k)) %to plot all 4 time bins
            subplot(4,4,i) %to plot only one time bin
            %H=plot(0:30:330',squeeze(Data(:,:,k,i)),'Color','b');
            hold on
            H=plot(0:30:330',mean(squeeze(Data(:,:,k,i))),'Color','b','MarkerSize',10);
            errorbar([0:30:330'],[mean(squeeze(Data(:,:,k,i)))],[std(squeeze(Data(:,:,k,i)))],'Color','b');
            set(H,'Clipping','off')
            axis([0 330 0 1])
            set(gca,'Xtick',[0 90 180 270],'Ytick',[0 1])
            if k==3
                ylabel(DATA_LST(i,:))
            end
        end
        if i==1, title(['Muscle tuning curves']); end
    elseif checkwalk==1 %Plot entire trial for walking data
        subplot(8,2,i) %to plot only one time bin
        plot(time,DATAsrc(i,:));
        ylim([0 1])
        xlim([0 time(end)])
        ylabel(DATA_LST(i,:))
    end
end
orient tall
guidata(hObject, handles); %updates the handles


%***********************************************
% Extract muscle synergies using NMF           *
%***********************************************

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global DATAsrc numsyn_nmf synergy_nmf

synergy_nmf={};
[nmus,nconds]=size(DATAsrc);

    for s=1:nmus
        synergy_nmf(s).nsyn=s; %The number of synergies
        [synergy_nmf(s).W,synergy_nmf(s).C,synergy_nmf(s).err,synergy_nmf(s).stdev] = NNMF_stacie_May2013(DATAsrc,s,1);
        [synergy_nmf(s).VAFcond, synergy_nmf(s).VAFmus, synergy_nmf(s).VAF]=funur(DATAsrc,synergy_nmf(s).W,synergy_nmf(s).C); %calculate VAF of reconstruction
        synergy_nmf(s).RECON = synergy_nmf(s).W*synergy_nmf(s).C;
    end

   
%****choose number of synergies and assign variables to plot
[numsyn_nmf]=choosesyns(DATAsrc,synergy_nmf);
set(handles.NMF_nsyn_toplot,'String',num2str(numsyn_nmf)); %set default number of synergies to plot
set(handles.PCA_nsyn_toplot,'String',num2str(numsyn_nmf)); %set default number of synergies to plot


function NMF_nsyn_toplot_Callback(hObject, eventdata, handles)
% hObject    handle to NMF_nsyn_toplot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NMF_nsyn_toplot as text
%        str2double(get(hObject,'String')) returns contents of NMF_nsyn_toplot as a double

global NMF_nsyn_toplot
NMF_nsyn_toplot=str2double(get(hObject,'String')); %returns contents of NMF_nsyn_toplot as a double


%***********************************************
% Plot NMF muscle synergies          *
%***********************************************

% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global DATAsrc DATA_LST synergy_nmf color time checkwalk ntrials ncond nbins

NMF_nsyn_toplot=str2double(get(handles.NMF_nsyn_toplot,'String')); %set default number of synergies to plot

Wnnmf=synergy_nmf(NMF_nsyn_toplot).W;
Hnnmf=synergy_nmf(NMF_nsyn_toplot).C;

%Determine the percentage of variability accounted for by each muscle
%synergy:
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
W=Wnnmf; C=Hnnmf;

[nmuscles nconds]=size(DATAsrc);
[nsyn ndum]=size(C);

%Calculate reconstructed values:
ReconData=W*C;

Wstr=mat2cell(W,[nmuscles],[ones(1,nsyn)]); % <1x7>
Cstr=mat2cell(C,[ones(1,nsyn)],[nconds]);
Recon_parts=cellfun(@(N1,N2) N1*N2,Wstr,Cstr','UniformOutput',0);

% Calculate contribution of each synergy to overall variability
synconstr=cellfun(@(D1) 100*sum(sum(D1))/sum(sum(ReconData)),Recon_parts,'UniformOutput',0);
syncontr=cell2mat(synconstr);
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


[nmus nsyn]=size(Wnnmf);

%for posture data:
if checkwalk==0;
    C=reshape(Hnnmf',ntrials,ncond,nbins,nsyn);
end 

%Plot the synergies in another figure
figure
for i=1:nsyn
    subplot(nsyn,2,(2*i)-1)
    b= bar(Wnnmf(:,i));
    set(b,'FaceColor',color(i,:),'EdgeColor',[1 1 1]);
    axis([0.5 nmus+.5 0 1])
    if i==1, title(['Synergies']); end
    xTickLabels=DATA_LST;
    htext=text((1:length(DATA_LST)), -0.1*ones(1,length(DATA_LST)), xTickLabels,'fontsize',10);
    set(htext,'Rotation',90,'HorizontalAlignment','right','FontSize',6);
    set(gca,'TickLength',[0 0])
    text(15,0.75,[num2str(round(syncontr(i))),'%'],'FontSize',6)

    if checkwalk==0;
    for k=3:3
        subplot(nsyn,2,2*i)
        errorbar([0:30:330'],[mean(squeeze(C(:,:,3,i)))],[std(squeeze(C(:,:,3,i)))],'Color',color(i,:));
        set(gca,'Clipping','off')
        axis([0 330 0 1])
        set(gca,'Xtick',[0 90 180 270],'Ytick',[0 1])
    end
    elseif checkwalk==1;
        subplot(nsyn,2,2*i)
        plot(time,Hnnmf(i,:),'Color',color(i,:))
        xlim([0 time(end)])
        ylim([0 1])
    end
    if i==1, title(['Weights']); end
end
orient tall

guidata(hObject, handles); %updates the handles


%***********************************************
% Plot VAF CI vs shuffled data              *
%***********************************************

% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global DATAsrc DATAshuff synergy_nmf synergy_nmf_shuff VAF_CI VAF_CI_shuff
nboot=100;

%Find the CI for the original data and synergies
[VAF_CI]=bootstrap_VAFCI(DATAsrc,synergy_nmf,nboot);

%shuffle the data
[nmus nconds]=size(DATAsrc);
DATAshuff=zeros(size(DATAsrc));
ind=zeros(size(DATAsrc));
for i=1:nmus
    ind(i,:)=randperm(nconds);
    DATAshuff(i,:)=DATAsrc(i,ind(i,:));
end

%extract muscle synergies from the shuffled data:
synergy_nmf_shuff={};
for s=1:nmus
    synergy_nmf_shuff(s).nsyn=s; %The number of synergies
    [synergy_nmf_shuff(s).W,synergy_nmf_shuff(s).C,synergy_nmf_shuff(s).err,synergy_nmf_shuff(s).stdev] = NNMF_stacie_May2013(DATAshuff,s,1);
    [synergy_nmf_shuff(s).VAFcond, synergy_nmf_shuff(s).VAFmus, synergy_nmf_shuff(s).VAF]=funur(DATAshuff,synergy_nmf_shuff(s).W,synergy_nmf_shuff(s).C); %calculate VAF of reconstruction
    synergy_nmf_shuff(s).RECON = synergy_nmf_shuff(s).W*synergy_nmf_shuff(s).C;
end

%Find the CI for the shuffled data and synergies
[VAF_CI_shuff]=bootstrap_VAFCI(DATAshuff,synergy_nmf_shuff,nboot);

%plot overall VAF CIs on same plot
figure
errorbar(1:nmus,mean(VAF_CI),[(VAF_CI(2,:)-VAF_CI(1,:))/2],'LineStyle','none','Color','r') %real data CI in red
xlabel('# of syns');ylabel('VAF (%)');
title('overall VAF')
hold on
errorbar(1:nmus,mean(VAF_CI_shuff),[(VAF_CI_shuff(2,:)-VAF_CI_shuff(1,:))/2],'LineStyle','none','Color','b') %shuffled data CI in blue
axis([0 nmus 40 100])


%***********************************************
% Extract PCA synergies              *
%***********************************************

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global DATAsrc COEFF SCORE pcvars

% %Scale the input data to have unit variance
% stdev = std(DATAsrc');
% DATAsrc = diag(1./stdev)*DATAsrc;

[COEFF,SCORE,pcvars] = princomp(DATAsrc','econ');

% %undo the unit variance scaling so synergies are back out of unit variance
% %space and in the same scaling as the input data was
% DATAsrc = diag(stdev)*DATAsrc;
% COEFF = diag(stdev)*COEFF;


function PCA_nsyn_toplot_Callback(hObject, eventdata, handles)
% hObject    handle to PCA_nsyn_toplot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of PCA_nsyn_toplot as text
%        str2double(get(hObject,'String')) returns contents of PCA_nsyn_toplot as a double

global PCA_nsyn_toplot
PCA_nsyn_toplot=str2double(get(hObject,'String')); %returns contents of PCA_nsyn_toplot as a double



%***********************************************
% Plot PCA synergies              *
%***********************************************

% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global DATAsrc COEFF SCORE pcvars DATA_LST color checkwalk time nmus ncond ntrials nbins

[nmus nconds]=size(DATAsrc);

PCA_nsyn_toplot=str2double(get(handles.PCA_nsyn_toplot,'String')); %set default number of synergies to plot
nsyn=PCA_nsyn_toplot;

%[residuals,reconstructed] = pcares(x,ndim)
VAFs_cum=cumsum(pcvars./sum(pcvars) * 100);
Wpca=COEFF(:,1:PCA_nsyn_toplot);
Hpca=SCORE(:,1:PCA_nsyn_toplot)';

if checkwalk==0
   C=reshape(Hpca',ntrials,ncond,nbins,nsyn);
end

%Calculate the VAF by each synergy to print on the plot
VAFs=[];
VAFs(1)=round(VAFs_cum(1));
for i=2:nsyn; VAFs(i)=round(VAFs_cum(i)-VAFs_cum(i-1)); end


%Plot the synergies in another figure
figure
for i=1:nsyn
    subplot(nsyn,2,(2*i)-1)
    b= bar(Wpca(:,i));
    set(b,'FaceColor',color(i,:),'EdgeColor',[1 1 1]);
    axis([0.5 nmus+.5 -1 1])
    if i==1, title(['Synergies']); end
    xTickLabels=DATA_LST;
    htext=text((1:length(DATA_LST)), -0.1*ones(1,length(DATA_LST)), xTickLabels,'fontsize',10);
    set(htext,'Rotation',90,'HorizontalAlignment','right','FontSize',6);
    set(gca,'TickLength',[0 0])
    text(15,0.75,[num2str(VAFs(i)),'%'],'FontSize',6)

    if checkwalk==0;
    for k=3:3
        subplot(nsyn,2,2*i)
        errorbar([0:30:330'],[mean(squeeze(C(:,:,3,i)))],[std(squeeze(C(:,:,3,i)))],'Color',color(i,:));
        set(gca,'Clipping','off')
        axis([0 330 -1 1])
        set(gca,'Xtick',[0 90 180 270],'Ytick',[-1 0 1])
    end
    if i==1, title(['Weights']); end
    elseif checkwalk==1;
        subplot(nsyn,2,2*i)
        plot(time,Hpca(i,:),'Color',color(i,:))
        ylim([-1 1])
        xlim([0 time(end)])
        set(gca,'Ytick',[-1 0 1])
    end
end
orient tall


guidata(hObject, handles); %updates the handles


function whichtrialNMF_Callback(hObject, eventdata, handles)
% hObject    handle to whichtrialNMF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of whichtrialNMF as text
%        str2double(get(hObject,'String')) returns contents of whichtrialNMF as a double

global whichtrial_NMF
whichtrial_NMF=str2double(get(hObject,'String')); %returns contents of NumPoints as a double


function whichtrialPCA_Callback(hObject, eventdata, handles)
% hObject    handle to whichtrialPCA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of whichtrialPCA as text
%        str2double(get(hObject,'String')) returns contents of whichtrialPCA as a double

global whichtrial_PCA
whichtrial_PCA=str2double(get(hObject,'String')); %returns contents of NumPoints as a double


% --- Executes on button press in reconNMF.
function reconNMF_Callback(hObject, eventdata, handles)
% hObject    handle to reconNMF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global whichtrial_NMF synergy_nmf DATAsrc color DATA_LST time checkwalk ncond ntrials nbins

NMF_nsyn_toplot=str2double(get(handles.NMF_nsyn_toplot,'String')); %set default number of synergies to plot

Wnnmf=synergy_nmf(NMF_nsyn_toplot).W;
Hnnmf=synergy_nmf(NMF_nsyn_toplot).C;

ReconNMF=Wnnmf*Hnnmf;

[nmus nsyn]=size(Wnnmf);
ReconPart=cell([nsyn 1]);
for k=1:nsyn
    ReconPart{k}=Wnnmf(:,k)*Hnnmf(k,:);
end

%for posture data:
if checkwalk==0;
    Data=reshape(DATAsrc',ntrials,ncond,nbins,nmus);
    ReconAll=reshape(ReconNMF',ntrials,ncond,nbins,nmus);
    
    % Partial reconstructions using each synergy
    for k=1:nsyn
        ReconPartsNMF(k,:,:,:,:)=reshape(ReconPart{k}',ntrials,ncond,nbins,nmus);
    end
    clear ReconPart;
elseif checkwalk==1;
    nmus=16;
    ReconPartsNMF=ReconPart;
end

figure
clf
set(gcf,'DefaultAxesFontName','Helvetica','DefaultAxesFontSize',9)
set(gcf,'PaperOrientation','landscape')

%for posture data:
if checkwalk==0;
    for k=1:nmus
        %for b=1:nbins
        for b=3:3  %plot only the third bin for now
            %subplot(nmus,nbins,((nbins)*(k-16))-(nbins-b)) %use this to show all muscles on one plot
            subplot(4,4,k) %to plot only one time bin

            %Plot only a single trial data and recon
            dat=squeeze(Data(:,:,b,k));
            reca=squeeze(ReconAll(:,:,b,k));
            H=plot(0:30:330',dat(whichtrial_NMF,:),'--','Color',[0 0 0]);  %%plot the first trial of data in dotted line
            hold on
            I=plot(0:30:330',reca(whichtrial_NMF,:),'Color',[0 0 0]);   %%plot the total recon of the first trial in solid line
            %shows r2 of the average real data and average reconstruction
            rsqr = (corr(dat(whichtrial_NMF,:)',reca(whichtrial_NMF,:)'))^2;
            text(10,0.8,['r2 =', ' ', num2str(rsqr)],'FontSize',10)
            %shows average VAF from each trial VAF b/w real and reconstructed
            ursqr = rsqr_uncentered(dat(whichtrial_NMF,:),reca(whichtrial_NMF,:));
            text(10,0.5,['VAF =', ' ', num2str(ursqr*100), ' %'],'FontSize',10)
            %plot each syn contribution
            for j=1:nsyn
                recp=squeeze(ReconPartsNMF(j,:,:,b,k));
                J=plot(0:30:330',recp(whichtrial_NMF,:),'Color',color(j,:));                       %%plot each synergy's contribution as line with std dev
            end

            if b==3
                ylabel(DATA_LST(k,:))
            end
            
            axis([0 330 0 1])
            set(gca,'Xtick',[0 90 180 270],'Ytick',[0 1])
        end
    end

%for walking data:
elseif checkwalk==1;
    k=[1:2:nmus 2:2:nmus];
    for i=1:nmus
        subplot(nmus/2,2,k(i))
        for j=1:nsyn
            ReconPart=ReconPartsNMF{j};
            plot(time,ReconPart(i,:)','Color',color(j,:),'LineWidth',2)
            hold on
            clear ReconPart
        end
        plot(time, DATAsrc(i,:),'--k','LineWidth',2) %measured EMG is dotted line
        plot(time, ReconNMF(i,:),'-k','LineWidth',1) %predicted EMG using synergies is solid line

        ymax=max(DATAsrc(i,:));
        rsqr = (corr(DATAsrc(i,:)',ReconNMF(i,:)'))^2;
        text(100,ymax/2,['r2 =', ' ', num2str(rsqr)],'FontSize',10)
        %shows average VAF from each trial VAF b/w real and reconstructed
        ursqr = rsqr_uncentered(DATAsrc(i,:),ReconNMF(i,:));
        text(100,ymax*(3/4),['VAF =', ' ', num2str(ursqr*100), ' %'],'FontSize',10)

        axis([time(1) time(end) 0 ymax]);

        %axis tight
        hold on
        ylabel(DATA_LST(i,:))
        hold off
    end
end
orient tall



% --- Executes on button press in reconPCA.
function reconPCA_Callback(hObject, eventdata, handles)
% hObject    handle to reconPCA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global whichtrial_PCA COEFF SCORE DATAsrc color DATA_LST time checkwalk nmus ncond ntrials nbins

PCA_nsyn_toplot=str2double(get(handles.PCA_nsyn_toplot,'String')); %set default number of synergies to plot

Wpca=COEFF(:,1:PCA_nsyn_toplot);
Hpca=SCORE(:,1:PCA_nsyn_toplot)';
ReconPCA=Wpca*Hpca;

% for posture data:
if checkwalk==0;
    Data=reshape(DATAsrc',ntrials,ncond,nbins,nmus);
    ReconAll=reshape(ReconPCA',ntrials,ncond,nbins,nmus);
elseif checkwalk==1;
    nmus=16;
end
nsyn=PCA_nsyn_toplot;


ReconPart=cell([nsyn 1]);
for k=1:nsyn
    ReconPart{k}=Wpca(:,k)*Hpca(k,:);
end

if checkwalk==0
    % Partial reconstructions using each synergy
    for k=1:nsyn
        ReconPartsPCA(k,:,:,:,:)=reshape(ReconPart{k}',ntrials,ncond,nbins,nmus);
    end
    clear ReconPart;
    
elseif checkwalk==1
    ReconPartsPCA=ReconPart;
end


figure
clf
set(gcf,'DefaultAxesFontName','Helvetica','DefaultAxesFontSize',9)
set(gcf,'PaperOrientation','landscape')

% for posture data:
if checkwalk==0;
    for k=1:nmus
        %for b=1:numbins
        for b=3:3  %plot only the third bin for now
            %subplot(nmus,numbins,((numbins)*(k-16))-(numbins-b)) %use this to show all muscles on one plot
            subplot(4,4,k) %to plot only one time bin

            %Plot only a single trial data and recon
            dat=squeeze(Data(:,:,b,k));
            reca=squeeze(ReconAll(:,:,b,k));
            H=plot(0:30:330',dat(whichtrial_PCA,:),'--','Color',[0 0 0]);  %%plot the first trial of data in dotted line
            hold on
            I=plot(0:30:330',reca(whichtrial_PCA,:),'Color',[0 0 0]);   %%plot the total recon of the first trial in solid line
            %shows r2 of the average real data and average reconstruction
            rsqr = (corr(dat(whichtrial_PCA,:)',reca(whichtrial_PCA,:)'))^2;
            text(10,0.8,['r2 =', ' ', num2str(rsqr)],'FontSize',10)
            %shows average VAF from each trial VAF b/w real and reconstructed
            ursqr = rsqr_uncentered(dat(whichtrial_PCA,:),reca(whichtrial_PCA,:));
            text(10,0.5,['VAF =', ' ', num2str(ursqr*100), ' %'],'FontSize',10)
            %plot each syn contribution
            for j=1:nsyn
                recp=squeeze(ReconPartsPCA(j,:,:,b,k));
                J=plot(0:30:330',recp(whichtrial_PCA,:),'Color',color(j,:));                       %%plot each synergy's contribution as line with std dev
            end

            if b==3
                ylabel(DATA_LST(k,:))
            end

            axis([0 330 -1 1])
            set(gca,'Xtick',[0 90 180 270],'Ytick',[-1 0 1])
        end
    end

elseif checkwalk==1;
    k=[1:2:nmus 2:2:nmus];
    for i=1:nmus
        subplot(nmus/2,2,k(i))
        for j=1:nsyn
            ReconPart=ReconPartsPCA{j};
            plot(time,ReconPart(i,:)','Color',color(j,:),'LineWidth',2)
            hold on
            clear ReconPart
        end
        plot(time, DATAsrc(i,:),'--k','LineWidth',2) %measured EMG is dotted line
        plot(time, ReconPCA(i,:),'-k','LineWidth',1) %predicted EMG using synergies is solid line
        
        ymax=max(DATAsrc(i,:));
        rsqr = (corr(DATAsrc(i,:)',ReconPCA(i,:)'))^2;
        text(100,ymax/2,['r2 =', ' ', num2str(rsqr)],'FontSize',10)
        %shows average VAF from each trial VAF b/w real and reconstructed
        ursqr = rsqr_uncentered(DATAsrc(i,:),ReconPCA(i,:));
        text(100,ymax*(3/4),['VAF =', ' ', num2str(ursqr*100), ' %'],'FontSize',10)

        axis([time(1) time(end) -1 1]);
        set(gca,'Ytick',[-1 0 1])

        %axis tight
        hold on
        ylabel(DATA_LST(i,:))
        hold off
    end
end
orient tall



% --- Executes during object creation, after setting all properties.
function whichtrialNMF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to whichtrialNMF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function whichtrialPCA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to whichtrialPCA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox_walking.
function checkbox_walking_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_walking (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_walking



% --- Executes during object creation, after setting all properties.
function NMF_nsyn_toplot_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NMF_nsyn_toplot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function PCA_nsyn_toplot_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PCA_nsyn_toplot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end







 function [W,H,err,stdev]=NNMF_stacie_May2013(V,r,flag)
% NNMF: Given a nonnegative matrix V, NNMF finds nonnegative matrix W 
%       and nonnegative coefficient matrix H such that V~WH. 
%       The algorithm solves the problem of minimizing (V-WH)^2 by varying W and H
%       Multiplicative update rules developed by Lee and Seung were used to solve 
%       optimization problem. (see reference below) 
%          D. D. Lee and H. S. Seung. Algorithms for non-negative matrix
%          factorization. Adv. Neural Info. Proc. Syst. 13, 556-562 (2001)
% Input: 
%
% V Matrix of dimensions n x m  Nonnegative matrix to be factorized   
% r Integer                     Number of basis vectors to be used for factorization
%                               usually r is chosen to be smaller than n or m so that 
%                               W and H are smaller than original matrix V
% flag                flag == 1; scale the input data to have unit variance 
%                     flag == 2; scale the input data to the unit variance scaling of a different data set
% 
% Output:
%
% W    Matrix of dimensions n x r  Nonnegative matrix containing basis vectors
% H    Matrix of dimensions r x m  Nonnegative matrix containing coefficients
% err  Integer                     Least square error (V-WH)^2 after optimization convergence  
% 
% Created: May 14, 2013 by SAC
% Last modified:
% Last modification: 

V = V.*(V>0); % Any potential negative entrie in data matrix will be set to zero

test=sum(V,2); % Any potential muscle channnel with only zeros is not included in the iteration 
index=find(test~=0);
ind=find(test==0);
Vnew_m=V(index,:);

test_cond=sum(V,1); % Any potential condition with only zeros is not included in the iteration 
index_cond=find(test_cond~=0);
ind_cond=find(test_cond==0);
Vnew=Vnew_m(:,index_cond);

%If attempting to extract more synergies than remaining
%muscles, extract only the number of synergies equal to number of muscles
[nummus,dum]=size(Vnew);
if r>nummus
    difference=r-nummus;
    rtemp=r-difference;
    r=rtemp;
end

% Scale the input data to have unit variance %%%%%%%%%
if flag ==1;
    stdev = std(Vnew'); %scale the data to have unit variance of this data set
elseif flag ==2;
    global stdev % use this if you want to use the stdev (unit variance scaling) from a different data set
end

Vnew = diag(1./stdev)*Vnew;
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

opts = statset('MaxIter',1000,'TolFun',1e-6,'TolX',1e-4);
[W,H,err] = nnmf(Vnew,r,'alg','mult','rep',50,'options',opts);
% [W,H,err] = nnmf(Vnew,r,'alg','mult','rep',50);


% Re-scale the original data and the synergies; add in zero rows; calculate 
% final error.

%undo the unit variance scaling so synergies are back out of unit variance
%space and in the same scaling as the input data was
Vnew = diag(stdev)*Vnew;
W = diag(stdev)*W;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Synergy vectors normalization  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

m=max(W);% vector with max activation values 
for i=1:r
    H(i,:)=H(i,:)*m(i);
    W(:,i)=W(:,i)/m(i);
end


% Set to zero the columns or rows that were not included in the iteration
[n_o,m_o]=size(V);

Hnew=[];
Wnew=[];
for l=1:length(ind_cond)
    if ind_cond(l)==1
        Hnew=[zeros(r,1) H];
        H=Hnew;
    elseif ind_cond(l)==m_o
        Hnew=[H zeros(r,1)];
        H=Hnew;
    else 
        for k=1:m_o
            if ind_cond(l)==k
                Hnew=[H(:,1:k-1) zeros(r,1) H(:,k:end)];
                H=Hnew; break
            else
                Hnew=H;
            end
        end
    end
end
for l=1:length(ind)
    if ind(l)==1
        Wnew=[zeros(1,r); W];
        W=Wnew;
    elseif ind(l)==n_o
        Wnew=[W; zeros(1,r)];
        W=Wnew;
    else 
        for k=1:n_o
            if ind(l)==k
                Wnew=[W(1:k-1,:); zeros(1,r); W(k:end,:)];
                W=Wnew; break
            else
                Wnew=W;
            end
        end
    end
end
%end function NNMF_stacie_May2013.m

 
function [numsyn]=choosesyns(DATA,synergy_nmf)
%choose based on overall VAF>90 and VAFmus>75

%compile all VAFmus
    VAFconds=[];
    for i=1:length(synergy_nmf)

        VAFs(i)=synergy_nmf(1,i).VAF;
        VAFmuss(i,:)=synergy_nmf(1,i).VAFmus;
    end
    minvafmus=min(VAFmuss,[],2);
    I=find(VAFs(:)>=90 & minvafmus(:)>=75);

% %compute a bootstrap CI around overall VAF
% %choose based on overall VAF CI (lower bound >90) and VAFmus>75
%     [VAF_CI]=bootstrap_VAFCI(DATA,synergy_nmf,500);
%     LB=VAF_CI(1,:);
%     I=find(LB(:)>=90 & minvafmus(:)>=75);
    
    numsyn=I(1);

%end function choosesyns.m



%bootstrap VAF code
function [VAF_CI]=bootstrap_VAFCI(DATA,synergy_nmf,nboot)

VAFtot=[];sortedVAF=[];

for s=1:length(synergy_nmf)
    Wnew=synergy_nmf(1,s).W;
    C=synergy_nmf(1,s).C;

    [nmus,nconds]=size(DATA);
    VAFall=[];

    %generate random index vector
    bootsam = ceil(nconds*rand(nconds,nboot));

    for iter=1:nboot
        
        %sample the data and use the same sample from C
        DATAsamp=DATA(:,bootsam(:,iter));
        Csamp=C(:,bootsam(:,iter));

        %reconstruct data and calculate VAF and VAFmus
        [VAFcond, VAFmus, VAF]=funur(DATAsamp,Wnew,Csamp);

        %store params
        VAFall(iter)=VAF;

        %clear temporary variables
        clear DATAsamp Csamp VAF VAFmus VAFcond
    end
    VAFtot(:,s)=VAFall;
    sortedVAF(:,s)=sort(VAFall);

    clear Wnew C err bootsam    
end

if nboot==100
    sampint=[3,98];
elseif nboot==500
    sampint=[13,488];
end

%Find the confidence intervals:
VAF_CI=[];

VAF_CI=sortedVAF(sampint,:);

for s=1:length(synergy_nmf)
    synergy_nmf(1,s).VAF_CI=VAF_CI(:,s);
end

%end function bootstrap_VAFCI


function [URcond, URmus, UR]=funur(data,W,C)
%[URcond, URmus, UR]=funur(data,w,c) 
% This function calculates uncentered correlation coefficients of data and
% reconstructed data = WC
% W and C are used to generate the reconstructed data (recdat= W*C)
% It determines the mean error in the overall reconstruction (UR)
% It determines the error in the reconstruction of each muscle tuning 
% curve (URmus) and each muscle activation pattern for every single
% perturbation direction (URcond)
% Input:
%       data    matrix of observed data  (e.g., data=[mus pert_dir])
%       W       matrix of synergy vectors 
%       C       matrix of coefficiens 
% Output:
%       URcond   matrix with error % for each condition(e.g., error= [pert_dir error])
%       URmus    matrix with error % for each muscle (e.g., error= [mus error])
%       UR       matrix with overall error
% called functions:
%       rsqr_uncentered.m 
%       
% 
% this function is called by:
%       plot_syn.m
%       plot_syn3D.m
%
% Written by: GTO May 24th, 2006
% Last modified:
%
%

[nmuscles ncond]=size(data);
[nsyn ndum]=size(C);

%Calculate reconstructed values
ReconData=W*C;

%Make fake reconstructed data with 70% error in the prediction
%ReconData=data.*1.7;
    
%Calculate error in the reconstruction of each direction
%URcond(1 x nconditions)
[URcond]=rsqr_uncentered(data',ReconData');
URcond=100*(URcond);   

%Calculate error in the reconstruction of each muscle activity level
%URmus(nmus x 1)
[URmus]=rsqr_uncentered(data,ReconData);    
URmus=100*(URmus);

%Calculate overall variability(1x1)
X=cat(3,data,ReconData);    
UR=(sum(sum(prod(X,3))))^2/(sum(sum(data.^2))*sum(sum(ReconData.^2)));
UR=100*UR;


function ursqr = rsqr_uncentered(data,data_rec)
% This function calculates the uncetered correlation coefficient using "Cluster" method.  
%
% Syntax:   r_sqr = rsqr_uncentered(data,data_rec)
%
% Input:
% data      Array   matrix of observed data  (e.g., data = [mus pert_dir])
% data_rec  Array   matrix of reconstructed/predicted data (e.g., data_rec = [mus pert_dir])
%
% Output:
% ursqr     Array   matrix with uncentered correlation coefficients
%
% Calls:
% std_mean0.m 
%       
% Created: May 24, 2006 (Gelsy Torres-Oviedo)
% Last Modified: July 10, 2006 (Torrence Welch)
% Last Modification: fix ursqr calculation

% Shift dimensions for regression purposes data magnitudes in rows and data channels in columns
warning off
data = data';
data_rec = data_rec';

% Zar book method p. 334
dim_data = size(data);
for i = 1:dim_data(2)
    X = [data(:,i) data_rec(:,i)];
    n = length(X);
    ursqr(i) = sum(prod(X,2))^2 / (sum(data(:,i).^2)*sum(data_rec(:,i).^2)); %regression sum of squares/total sum of squares
end

ursqr = ursqr';
return
%========================
% end rsqr_uncentered.m


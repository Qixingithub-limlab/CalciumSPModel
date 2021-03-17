clear
pramset=1;
if pramset==1
    %cortical linear model (JN)
    tauCa = 0.0222721171; 
    thetaD  = 1.;
    thetaP  = 2.00928899;
    gammaD  = 137.758631;
    gammaP  = 597.089216;
    sigma   = 1;
    tau     = 520.761286;
    rhoStar = 0.5;
    D       = 0.00953708736;
    beta    = 0.5;
    b       = 2;
    Cpre  = 8.44990637e-01;
    Cpost = 1.62137900e+00;
elseif pramset==2
    %hippocampal slice
    tauCa=0.0488373; 
    Cpre = 1.;
    Cpost = 0.275865;
    thetaD  = 1.;
    thetaP  = 1.3;
    gammaD  = 313.0965;
    gammaP  = 1645.59;
    sigma   = 9.1844;
    tau     = 688.355;
    rhoStar = 0.5;
    D       = 0.0188008;
    beta    = 0.7;
    b       = 5.28145;
elseif pramset==3
    %cortical slice (PNAS)
    tauCa = 0.0226936;
    Cpre = 0.5617539;
    Cpost = 1.23964;
    thetaD  = 1.;
    thetaP  = 1.3;
    gammaD  = 331.909;
    gammaP  = 725.085;
    sigma   = 3.3501;
    tau     = 346.3615;
    rhoStar = 0.5;
    D       = 0.0046098;
    beta    = 0.5;
    b       = 5.40988;
elseif pramset==4
    %hippocampal culture
    tauCa = 0.0119536;
    Cpre = 0.58156;
    Cpost = 1.76444;
    thetaD  = 1.;
    thetaP  = 1.3;
    gammaD  = 61.141;
    gammaP  = 113.6545;
    sigma   = 2.5654;
    tau     = 33.7596;
    rhoStar = 0.5;
    D       = 0.01;
    beta    = 0.5;
    b       = 36.0263;
end

%% Generate 2D rate based synaptic plasticity map 
frequencies=0.5:1:50;
[fpre2d,fpost2d]=meshgrid(frequencies,frequencies);
fpre2d=fpre2d(:);
fpost2d=fpost2d(:);

dW1=zeros(size(fpre2d)); 
dW2=zeros(size(fpre2d));
dWvar=zeros(size(fpre2d));
 
tic
parfor i=1:length(fpre2d)    
    [dW1(i),dW2(i),dWvar(i)]=synapticChange(fpre2d(i),fpost2d(i),Cpre,Cpost,tauCa,thetaD,thetaP,gammaD,gammaP,sigma,tau,rhoStar,D,beta,b);    
end
toc

fsize=length(frequencies);
dW1=reshape(dW1,fsize,fsize);
dW2=reshape(dW2,fsize,fsize);
dWvar=reshape(dWvar,fsize,fsize); %2D variance map

%% JN uses dW1
figure;
imagesc('XData',frequencies,'YData',frequencies,'CData',(dW1-0.5)/0.5)
axis equal
axis tight
colorbar
colormap(bluewhitered(0))

%% PNAS uses dW2
figure
imagesc('XData',frequencies,'YData',frequencies,'CData',dW2)
axis equal
axis tight
colorbar
caxis([0.65 1.35])
colormap(bluewhitered(1))

%%
save(['./dWmatrices/finer_paramset',num2str(pramset),'.mat'],'frequencies','dW1','dW2','dWvar','-v7.3')

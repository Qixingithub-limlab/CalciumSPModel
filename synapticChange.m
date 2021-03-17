function [mean,synChange,var]=synapticChange(preRate,postRate,Cpre,Cpost,tauCa,thetaD,thetaP,gammaD,gammaP,sigma,tau,rhoStar,D,beta,b)

dT = 0;
ppp=0;
deltaCa=0.005;
T_total=10;
rho0=0.5;

alphas=py.timeAbovethreshold.changeInSynapticStrength(dT,tauCa,Cpost,Cpre,thetaD,thetaP,preRate,postRate,ppp,deltaCa);
alphaD=alphas{1};
alphaP=alphas{2};

GammaP=gammaP*alphaP;
GammaD=gammaD*alphaD;
rhoBar=GammaP/(GammaP+GammaD);
sigmaRhoSquared = (alphaP + alphaD)*(sigma^2)/(GammaP + GammaD);

tauEff = tau/(GammaP + GammaD);

UP   = transitionProbability(T_total,0.,rhoBar,sigmaRhoSquared,tauEff,rhoStar);
DOWN = transitionProbability(T_total,1.,rhoBar,sigmaRhoSquared,tauEff,rhoStar);
meanUP   =  rhoBar - (rhoBar - 0.)*exp(-T_total/tauEff);
meanDOWN =  rhoBar - (rhoBar - 1.)*exp(-T_total/tauEff);
mean     =  rhoBar - (rhoBar - rho0)*exp(-T_total/tauEff);
var      =  sigmaRhoSquared * (1-exp(-2*T_total/tauEff))/2;
synChange = ((beta*(1.-UP) + (1.-beta)*DOWN) + (beta*UP+ (1.-beta)*(1.-DOWN))*b)/(beta + (1.-beta)*b);

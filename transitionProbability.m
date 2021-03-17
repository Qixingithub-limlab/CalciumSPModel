function tp=transitionProbability(T_total,rho0,rhoBar,sigmaRhoSquared,tauEff,rhoStar)
x1 =  -(rhoStar - rhoBar + (rhoBar - rho0)*exp(-T_total/tauEff))/(sqrt(sigmaRhoSquared*(1.-exp(-2.*T_total/tauEff))));

if rho0 == 0
    tp= (1. + erf(x1))/2;
else
    tp= (1. - erf(x1))/2;
end
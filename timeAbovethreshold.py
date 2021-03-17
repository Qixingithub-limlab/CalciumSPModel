import subprocess

# tauCa = 0.0226936 # in sec
# thetaD  = 1.
# thetaP  = 1.3
# gammaD  = 331.909
# gammaP  = 725.085
# sigma   = 3.3501
# tau     = 346.3615
# rhoStar = 0.5
# D       = 0.0046098 # in sec
# beta    = 0.5
# b       = 5.40988


# Cpre  = 8.44990637e-01
# Cpost = 1.62137900e+00
# dT = 0
# ppp=0
# preRate=10
# postRate=10
# deltaCa=0.005
def changeInSynapticStrength(dT,tauCa,Cpost,Cpre,thetaD,thetaP,preRate,postRate,ppp,deltaCa):
    if Cpre>Cpost:
            arguments = str(dT) + ' ' + str(tauCa) + ' ' + str(Cpost) + ' ' + str(Cpre) + ' ' + str(thetaD) + ' ' + str(thetaP) + ' ' + str(preRate) + ' ' + str(postRate) + ' ' + str(ppp) + ' ' + str(deltaCa)
    else:
            arguments = str(dT) + ' ' + str(tauCa) + ' ' + str(Cpre) + ' ' + str(Cpost) + ' ' + str(thetaD) + ' ' + str(thetaP) + ' ' + str(preRate) + ' ' + str(postRate) + ' ' + str(ppp) + ' ' + str(deltaCa)

    #print arguments
    #(out,err) = commands.getstatusoutput('./timeAboveThreshold/poissonPairs_timeAboveThreshold ' + arguments) 
    (out,err) = subprocess.getstatusoutput('D:/Documents/Lim_Lab/CalciumModel/poissonPairs_timeAboveThreshold ' + arguments) 
    alphaD = float(err.split()[0])
    alphaP = float(err.split()[1])
    return alphaD,alphaP
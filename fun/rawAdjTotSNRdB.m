function [y] = rawAdjTotSNRdB(x01,x02,newSNR)
    y = ((x02 / rawNrm(x02)) * rawNrm(x01)) / (db2pow(0.5*newSNR));
    if 0
        10.0^(0.05*newSNR)
        db2pow(0.5*newSNR)

        x01 = randn(1000,5)*6;
        x01(:,1) = x01(:,1)/6;
        x02 = randn(1000,5);
        newSNR = 2
        rawSNRdB(x01,x02)
        x03 = rawAdjTotSNRdB(x01,x02,newSNR);
        rawSNRdB(x01,x02)
        rawSNRdB(x01,x03)
        m02 = mean(x02)
        m03 = mean(x03)
        m02(1)/m02(2)
        m03(1)/m03(2)

        x01 = randn(1000,20);
        x02 = randn(1000,10);
        size(x01,2)/size(x02,2)
        rawSNR(x01,x02)
        rawSNRdB(x01,x02)
        rawNrm(x01)
        rawNrm(x02)
        rawNrmCol(x01)
        rawNrmCol(x02)
        rawSNRdB(x01,x02)
        2*pow2db(rawNrm(x01)./rawNrm(x02))
        2*pow2db(rawNrmCol(x01)./rawNrmCol(x02))
        rawSNRdB(x01(:,1),x02(:,1))
        x02 = rawAdjTotSNRdB(x01,x02,10);

        x01 = randn(1000,5)*6;
        x02 = randn(1000,5);
        rawNrm(x02)
        tmp_old_prop = rawNrmCol(x02)
        rawSNR(x01,x02)
        rawSNRdB(x01,x02)
        tmp_newSNR = 3
        % [bandpower(x01);bandpower(x02)]
        x02 = rawAdjTotSNRdB(x01,x02,tmp_newSNR);
        % x02 = x02 / rawNrm(x02)*rawNrm(x01) / (db2pow(0.5*tmp_newSNR));
        % [bandpower(x01);bandpower(x02)]
        rawSNR(x01,x02)
        rawSNRdB(x01,x02)
        tmp_new_prop = rawNrmCol(x02)
        tmp_new_prop./tmp_old_prop
    end
end

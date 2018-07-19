function [H,varargout] = rawIsStableMVAR(A00,varargin)
    if isempty(varargin)
        STAB = 1;
        disp(['Checking if eigenvalues are inside unit circle.']);
    elseif length(varargin) == 1
        STAB = varargin{1};
        disp(['Checking if eigenvalues are inside circle with radius of ',num2str(STAB) ,'.']);
    else
        error('Too many input arguments');
    end
    S00          = size(A00,1);                  % dimension of state vectors
    P00          = size(A00,2)/S00;                % order of process
    tmp_lambda   = eig([A00; eye((P00-1)*S00) zeros((P00-1)*S00,S00)]);
    H            = ~any(abs(tmp_lambda)>STAB);
    varargout{1} = max(abs(tmp_lambda));
end

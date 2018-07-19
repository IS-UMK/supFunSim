function M00 = cccSim___diagonMask(S00,M00_frc)
% cccSim___diagonMask produces masking square array M (SxS) whose all diagonal and some off-diagonal elements are ones. All
% othere elements are zeros. The off-diagonal elements are sampled pseudo-randomly and their number is declared by
% second argument of this function which should be a number between zero and one that describes the proportion of ones
% to zeros among all off-diagonal elements of the resulting array.
%
% Usage:
%
%    MSK = cccSim___diagonMask(S,frac)

% Copyright (C) 2000-2015, Jan (CyberCraft) Nikadon (nikadon-AT-SIGN-gmail.com)
%
%    This file is free software and a part of CyberCraft Toolkit.  You can redistribute it and/or modify it under the
%    terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the
%    License, or (at your option) any later version.
%
%    CyberCraft is distributed in the hope that it will be useful,
%    but WITHOUT ANY WARRANTY; without even the implied warranty of
%    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%    GNU General Public License for more details.
%
%    You should have received a copy of the GNU General Public License
%    along with CyberCraft. If not, see <http://www.gnu.org/licenses/>.

    if 0
        % Example useage:
        S00     = 10;
        M00_frc = 0.1;
        M00     = cccSim___diagonMask(S00,M00_frc)
        figure(1);clf;
        imagesc(M00);colorbar;
        (numel(find(M00))-S00) / (numel(M00)-S00)
        imagesc(sim_sig00.M00);colorbar;
    end
    M00     = eye(S00);
    M00_idx = find(~M00);
    M00_smp = datasample(M00_idx,round(M00_frc*numel(M00_idx)),'Replace',false);
    M00(M00_smp) = deal(1);
end

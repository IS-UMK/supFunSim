LOOP

% USED FOR SAVING FIGURES
myName = ['./fig___',LOOP.DATE,'___',LOOP.NAME,'___',datestr(now,'yyyymmdd_HHMMSS')];

% use LOOP.RES.ITERATION{x}{y}(z) to access results struct for 
% z-th activity index (z=1,2,...,8 with z=1 for MAI(2011) etc., as defined in !run MAI and MPZ Locallizers) 
% y-th level of SNR of type considered (interference, biological, measurement)
% x-th iteration of the experiment

% XRANK is an array of size |x| by |y|, representing ranks selected for reduced-rank indices
XRANK=zeros(LOOP.totSimCount,length(LOOP.(LOOP.NamNoise)));

% number of simulation runs
for i=1:LOOP.totSimCount
    % number of levels of SNR
    for j=1:length(LOOP.(LOOP.NamNoise))
	XRANK(i,j)=max([LOOP.RES.ITERATION{i}{j}(1).sources.rank_opt]);
    end
end

% XRES is an array of size |x| by |y| by |z| by |#sources|, representing errors for each source
% found using iterative procedure
XRES=zeros(LOOP.totSimCount,length(LOOP.(LOOP.NamNoise)),8,sum(SETUP.SRCS(:,1)));

% number of simulation runs
for i=1:LOOP.totSimCount
    % number of levels of SNR
    for j=1:length(LOOP.(LOOP.NamNoise))
	% number of activity indices
	for k=1:8
	    XRES(i,j,k,:)=[LOOP.RES.ITERATION{i}{j}(k).sources.distance]';
	end 
    end 
end

% RRES is same like XRES, with the trailing few sources considered
RRES=XRES(:,:,:,end-1:end);

% |x| by |y| by |z| array, with last dimension representing mean of errors across sources discovered
XRES_s = mean(XRES,4);
RRES_s = mean(RRES,4);

% |y| by |z| matrix, with entries representing averaged mean error and its std across experiment repetitions
XRES_sa = squeeze(mean(XRES_s,1));
XRES_sstd = squeeze(std(XRES_s,1));
RRES_sa = squeeze(mean(RRES_s,1));
RRES_sstd = squeeze(std(RRES_s,1));

% change order of and remove some activity indices as:
% 1 = MAI(2011), 2 = MAI(2013), 3 = MAI_RR_I
% 4 = MPZ(2011), 5 = MPZ(2013), 6 = MPZ_RR_I
XRES_s = XRES_s(:,:,[1 2 5 3 4 7]);
RRES_s = RRES_s(:,:,[1 2 5 3 4 7]);

XRES_sa = XRES_sa(:,[1 2 5 3 4 7]);
XRES_sstd = XRES_sstd(:,[1 2 5 3 4 7]);

RRES_sa = RRES_sa(:,[1 2 5 3 4 7]);
RRES_sstd = RRES_sstd(:,[1 2 5 3 4 7]);

% Mann-Whitney U-test to check whether proposed activity indices achieve 
% significantly lower average localization error

% XRES_U and RRES_U are |y| by 4 (# of comparisons) storing resulting p-values of performed Mann-Whitney U test
XRES_U=zeros(length(LOOP.(LOOP.NamNoise)),4);
RRES_U=zeros(length(LOOP.(LOOP.NamNoise)),4);

for j=1:length(LOOP.(LOOP.NamNoise))
    XRES_U(j,1)=ranksum(XRES_s(:,j,1),XRES_s(:,j,3),'tail','right');
    XRES_U(j,2)=ranksum(XRES_s(:,j,2),XRES_s(:,j,3),'tail','right');
    XRES_U(j,3)=ranksum(XRES_s(:,j,4),XRES_s(:,j,6),'tail','right');
    XRES_U(j,4)=ranksum(XRES_s(:,j,5),XRES_s(:,j,6),'tail','right');
end

for j=1:length(LOOP.(LOOP.NamNoise))
    RRES_U(j,1)=ranksum(RRES_s(:,j,1),RRES_s(:,j,3),'tail','right');
    RRES_U(j,2)=ranksum(RRES_s(:,j,2),RRES_s(:,j,3),'tail','right');
    RRES_U(j,3)=ranksum(RRES_s(:,j,4),RRES_s(:,j,6),'tail','right');
    RRES_U(j,4)=ranksum(RRES_s(:,j,5),RRES_s(:,j,6),'tail','right');
end

% pad with zero vectors to increase spacing between bar groups
XRES_sa = [XRES_sa; zeros(2,6)];
XRES_sstd = [XRES_sstd; zeros(2,6)];

RRES_sa = [RRES_sa; zeros(2,6)];
RRES_sstd = [RRES_sstd; zeros(2,6)];

clear gca;      
figure
name = {'MAI';'MAI_{ext}';'MAI_{RR-I}';'MPZ';'MPZ_{ext}';'MPZ_{RR-I}'};
bar(XRES_sa',1.2);
hold on
bar(XRES_sstd',1.2,'FaceColor',[0 0 0])
hold off
f=get(gca,'Children');
f=flipud(f(3:end));
lgd=strsplit(num2str(LOOP.(LOOP.NamNoise),'%d '));
% need to skip items in legend
for i=1:length(lgd)
    legendInfo{i} = ['SNR = ', lgd{i}, ' dB']; 
end
l=legend(f,legendInfo);	
l.Location='northwest';
set(gca,'XTickLabel',name);
ylabel('Average localization error [mm]')
% ax = findobj(gcf,'type','axes'); 
print(gcf,[fullfile(pwd,filesep), strcat(myName,'_XRES_')],'-depsc')

figure
bar(RRES_sa',1.2);
hold on
bar(RRES_sstd',1.2,'FaceColor',[0 0 0])
hold off
f=get(gca,'Children');
f=flipud(f(3:end));
l=legend(f,legendInfo);
l.Location='northwest';
set(gca,'XTickLabel',name);
ylabel('Average localization error [mm]')
print(gcf,[fullfile(pwd,filesep), strcat(myName,'_RRES_')],'-depsc')

clear gca;
figure
plot(XRANK,'-o','MarkerIndices',1:LOOP.totSimCount,'LineWidth',2);
f=get(gca,'Children');
f=flipud(f);
l=legend(f,legendInfo);
l.Location='northwest';
axis([1 LOOP.totSimCount 1 sum(SETUP.SRCS(:,1))])
xlabel('Simulation run')
xticks([1:LOOP.totSimCount])
ylabel('Rank selected')
yticks([1:sum(SETUP.SRCS(:,1))])
print(gcf,[fullfile(pwd,filesep), strcat(myName,'_XRANK_')],'-depsc')

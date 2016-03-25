% Face recognition using eigenfaces

close all, clear, clc;

%% 20 random splits
num_trainImg = 5;
showEigenfaces = true;

%% load data
disp('loading data...');
dataDir = './CroppedYale';
datafile = 'Yale.mat';
if ~exist(datafile, 'file')
	readYaleDataset(dataDir, datafile);
end
load(datafile);

%% Five images per class are randomly chosen as the training
%% dataset and remaining images are used as the test dataset
disp('get training and testing data...');
num_class = size(unique(labels), 2);
trainIdx = [];
testIdx = [];
for i=1:num_class
	label = find(labels == i);
	indice = randperm(numel(label));
	trainIdx = [trainIdx label(indice(1:num_trainImg))];
	testIdx = [testIdx label(indice(num_trainImg+1:end))];
end

%% get train and test data
train_x = double(data(:, trainIdx));
train_y = labels(trainIdx);
test_x = double(data(:, testIdx));
test_y = labels(testIdx);

%% computing eigenfaces using PCA
disp('computing eigenfaces...');
tic;
[num_dim, num_imgs] = size(train_x);   %% A: #dim x #images
avg_face = mean(train_x, 2); 			 %% computing the average face
X = bsxfun(@minus, train_x, avg_face); %% computing the difference images

%% PCA
if num_dim <= num_imgs 
	C = X * X';
	[V, D] = eig(C);
else
	C = X' * X; 
	[U, D] = eig(C);
	V = X * U;
end
eigenfaces = V;
eigenfaces = eigenfaces ./ (ones(size(eigenfaces,1),1) * sqrt(sum(eigenfaces.*eigenfaces)));
toc;

%% visualize the average face
P = sqrt(numel(avg_face));
Q = numel(avg_face) / P;
imagesc(reshape(avg_face, P, Q)); title('Mean face');
colormap('gray');

%% visualize some eigenfaces
figure;
num_eigenfaces_show = 9;
for i = 1:num_eigenfaces_show
	subplot(3, 3, i)
	imagesc(reshape(eigenfaces(:, end-i+1), P, Q));
	title(['Eigenfaces ' num2str(i)]);
end
colormap('gray');

%% transform all training images to eigen space (each column for each image)
disp('transform data to eigen space...');
X = bsxfun(@minus, train_x, avg_face);
T = eigenfaces' * X;

%% transform the test image to eigen space
X_t = bsxfun(@minus, test_x, avg_face);
T_t = eigenfaces' * X_t;

%% find the best match using Euclidean distance
disp('find the best match...');
AB = -2 * T_t' * T;       % N x M
BB = sum(T .* T);         % 1 x M
distance = bsxfun(@plus, AB, BB);        % N x M
[score, index] = min(distance, [], 2);   % N x 1

%% compute accuracy
matchCount = 0;
for i=1:numel(index)
	predict = train_y(index(i));
	if predict == test_y(i)
		matchCount = matchCount + 1;
	end
end

fprintf('**************************************\n');
fprintf('accuracy: %0.3f%% \n', 100 * matchCount / numel(index));
fprintf('**************************************\n');
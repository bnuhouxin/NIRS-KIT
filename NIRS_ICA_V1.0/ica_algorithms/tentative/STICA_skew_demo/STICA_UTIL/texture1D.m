function v0 = texture1D(len,rho);% Place dots in 1D array at random positions.% Pick position at random.a = randperm(len)/len;v0 = a<=rho; % a now has 1's at random rho*image_len positions
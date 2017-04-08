function pokemonGO(with,wo,arr)
withPokeballs = [wo(1:end-4) '_captured.png'];
personalPokedex = [wo(1:end-4) '_pokedex.png'];
img1 = imread(with);
img2 = imread(wo);
copy = img2;
[r c] = size(img1);
pokePicArr = [];
%step uno: go through image and find pokemon
num = r./5;
for i = 1:num:r
    for int = 1:num:r
        pokemon = pokedex(img1(i:num+i-1,int:num+int-1,:),(arr));
        if ~isequal(pokemon,'No pokemon detected.')
            %found pokemon, match with pokeball
            %get pokemon name
            name = strtok(pokemon,',');
            %find pokemon in pokedex and get rarity and img
            for j = 1:length(arr)
                if isequal(arr(j).pokemon,name)
                    rarity = arr(j).rarity;
                    pokePic = arr(j).image;
                end
            end
            %get pokeball
            switch rarity
                case 'common'
                    file = 'pokeball.png';
                case 'uncommon'
                    file = 'greatball.png';
                case 'rare'
                    file = 'ultraball.png';
                case 'legendary'
                    file = 'masterball.png';        
            end
            %replace pokemon with ball type
            pokeball = imread(file);
            pokeball = imresize(pokeball,[num num]);
            img2(i:num+i-1,int:num+int-1,:) = pokeball;     
            %resize image and put in personal pokedex
            pokePic = imresize(pokePic,[100 100]);
            pokePicArr = [pokePicArr pokePic];
        end     
    end
end
%take green out of pic
logMat = (img2(:,:,1) == 0 & img2(:,:,2) == 255 & img2(:,:,3) == 0);
mask(:,:,1) = logMat;
mask(:,:,2) = logMat;
mask(:,:,3) = logMat;
img2(mask) = copy(mask);
imwrite(pokePicArr,personalPokedex);
imwrite(img2,withPokeballs);
end
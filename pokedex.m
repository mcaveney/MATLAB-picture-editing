% pokedex identify which pokemon, if any, is pictured in an image
%
% Inputs:
%   (uint8) An image that may or may not contain a pokemon
%   (struct) A structure array that must at least contain the fields "image",
%       "pokemon", and "description"
%
% Outputs:
%   (char) A string describing the pokemon found, or 'No pokemon detected' if
%       the image did not match any of the pokemon in the given Pokedex

function [out] = pokedex(in, nationalPokedex)
s = size(in);
out = 'No pokemon detected.';
for i = 1:length(nationalPokedex)
    pokedexIm = nationalPokedex(i).image;
    pokedexIm = imresize(pokedexIm,[s(1) s(2)]);
    mask = pokedexIm(:,:,1) == 0 & pokedexIm(:,:,2) == 0 & pokedexIm(:,:,3) == 0;
    mask3 = cat(3, ~mask, ~mask, ~mask);
    foundPokemon = isequal(in(mask3), pokedexIm(mask3));
    if foundPokemon
        out = [nationalPokedex(i).pokemon ', the ' nationalPokedex(i).description ' pokemon.'];
        return;
    end
end
end
launchStoryboard('chars/necc/intro.def')

for i = matchno(), 2 do
	if not launchFight{exclude = {"ajit", "ajit/ajix.def", "baxt/baxx.def", "baxt", "bern/berx.def", "bern", "boun/boux.def", "boun", "cici", "cici/cicx.def", "ikue/ikux.def", "ikue", "isab", "isab/isak.def", "isab/isax.def", "jane/janx.def", "jane", "just/jusx.def", "just", "reap/reax.def", "reap", "teri", "teri/terx.def", "wall/walx.def", "wall", "sher/shex.def", "sher", "tsug/tsux.def", "tsug", "goli/golx.def", "goli", "emic", "emic/emix.def", "necc", "necc/necx.def", "lucy", "lucy/lucx.def", "gabb", "gabb/gabx.def", "tyra", "tyra/tyrx.def", "tyra/tyrx.def", "wall/walk.def", "lucy/luck.def"}} then return end
end

if matchno() == 3 then
	if not launchFight{p2char = {"wall/walk.def"}} then return end
end

for i = matchno(), 5 do
	if not launchFight{exclude = {"ajit", "ajit/ajix.def", "baxt/baxx.def", "baxt", "bern/berx.def", "bern", "boun/boux.def", "boun", "cici", "cici/cicx.def", "ikue/ikux.def", "ikue", "isab", "isab/isak.def", "isab/isax.def", "jane/janx.def", "jane", "just/jusx.def", "just", "reap/reax.def", "reap", "teri", "teri/terx.def", "wall/walx.def", "wall", "sher/shex.def", "sher", "tsug/tsux.def", "tsug", "goli/golx.def", "goli", "emic", "emic/emix.def", "necc", "necc/necx.def", "lucy", "lucy/lucx.def", "gabb", "gabb/gabx.def", "tyra", "tyra/tyrx.def", "tyra/tyrx.def", "lucy/luck.def"}} then return end
end

if matchno() == 6 then
	if not launchFight{p2char = {"lucy/luck.def"}} then return end
end

if matchno() == 7 then
	if not launchFight{p2char = {"isab/isak.def"}} then return end
end

if matchno() == 8 then
	if not launchFight{p2char = {"tyra/tyrk.def"}} then return end
end

setMatchNo(-1)
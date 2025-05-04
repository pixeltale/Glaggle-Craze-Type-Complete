launchStoryboard('chars/boun/intro.def')

for i = matchno(), 2 do
	if not launchFight{exclude = {"ajit", "ajit/ajix.def", "baxt", "baxt/baxx.def", "bern", "bern/berx.def", "boun", "boun/boux.def", "cici", "cici/cicx.def", "ikue", "ikue/ikux.def", "isab", "isab/isak.def", "isab/isax.def", "jane", "jane/janx.def", "just", "just/jusx.def", "reap", "reap/reax.def", "teri", "teri/terx.def", "wall", "wall/walx.def", "sher", "sher/shex.def", "tsug", "tsug/tsux.def", "goli", "goli/golx.def", "emic", "emic/emix.def", "necc", "necc/necx.def", "lucy", "lucy/lucx.def", "gabb", "gabb/gabx.def", "tyra", "tyra/tyrx.def", "tyra/tyrk.def", "ajit/ajik.def", "lucy/luck.def"}} then return end
end

if matchno() == 3 then
	if not launchFight{p2char = {"lucy/luck.def"}} then return end
end

for i = matchno(), 5 do
	if not launchFight{exclude = {"ajit", "ajit/ajix.def", "baxt", "baxt/baxx.def", "bern", "bern/berx.def", "boun", "boun/boux.def", "cici", "cici/cicx.def", "ikue", "ikue/ikux.def", "isab", "isab/isak.def", "isab/isax.def", "jane", "jane/janx.def", "just", "just/jusx.def", "reap", "reap/reax.def", "teri", "teri/terx.def", "wall", "wall/walx.def", "sher", "sher/shex.def", "tsug", "tsug/tsux.def", "goli", "goli/golx.def", "emic", "emic/emix.def", "necc", "necc/necx.def", "lucy", "lucy/lucx.def", "gabb", "gabb/gabx.def", "tyra", "tyra/tyrx.def", "tyra/tyrk.def", "ajit/ajik.def"}} then return end
end

if matchno() == 6 then
	if not launchFight{p2char = {"ajit/ajik.def"}} then return end
end

if matchno() == 7 then
	if not launchFight{p2char = {"isab/isak.def"}} then return end
end

if matchno() == 8 then
	if not launchFight{p2char = {"tyra/tyrk.def"}} then return end
end

setMatchNo(-1)

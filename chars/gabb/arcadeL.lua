launchStoryboard('chars/gabb/intro.def')

for i = matchno(), 2 do
	if not launchFight{exclude = {"ajit", "ajit/ajik.def", "baxt/baxk.def", "baxt", "bern/berk.def", "bern", "boun/bouk.def", "boun", "cici", "cici/cick.def", "ikue/ikuk.def", "ikue", "isab", "isab/isak.def", "isab/isax.def", "jane/jank.def", "jane", "just/jusk.def", "just", "reap", "reap/reak.def", "teri", "teri/terk.def", "wall/walk.def", "wall", "sher", "sher/shek.def", "tsug", "tsug/tsuk.def", "goli", "goli/golk.def", "emic", "emic/emik.def", "necc", "necc/neck.def", "lucy", "lucy/luck.def", "gabb", "gabb/gabk.def", "tyra", "tyra/tyrx.def", "tyra/tyrk.def", "ajit/ajix.def", "sher/shex.def"}} then return end
end

if matchno() == 3 then
	if not launchFight{p2char = {"sher/shex.def"}} then return end
end

for i = matchno(), 5 do
	if not launchFight{exclude = {"ajit", "ajit/ajik.def", "baxt/baxk.def", "baxt", "bern/berk.def", "bern", "boun/bouk.def", "boun", "cici", "cici/cick.def", "ikue/ikuk.def", "ikue", "isab", "isab/isak.def", "isab/isax.def", "jane/jank.def", "jane", "just/jusk.def", "just", "reap", "reap/reak.def", "teri", "teri/terk.def", "wall/walk.def", "wall", "sher", "sher/shek.def", "tsug", "tsug/tsuk.def", "goli", "goli/golk.def", "emic", "emic/emik.def", "necc", "necc/neck.def", "lucy", "lucy/luck.def", "gabb", "gabb/gabk.def", "tyra", "tyra/tyrx.def", "tyra/tyrk.def", "ajit/ajix.def"}} then return end
end

if matchno() == 6 then
	if not launchFight{p2char = {"ajit/ajix.def"}} then return end
end

if matchno() == 7 then
	if not launchFight{p2char = {"isab/isax.def"}} then return end
end

if matchno() == 8 then
	if not launchFight{p2char = {"tyra/tyrx.def"}} then return end
end

setMatchNo(-1)

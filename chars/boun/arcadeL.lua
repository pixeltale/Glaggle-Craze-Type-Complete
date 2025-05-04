launchStoryboard('chars/boun/intro.def')

for i = matchno(), 2 do
	if not launchFight{exclude = {"ajit", "ajit/ajik.def", "baxt", "baxt/baxk.def", "bern", "bern/berk.def", "boun", "boun/bouk.def", "cici", "cici/cick.def", "ikue", "ikue/ikuk.def", "isab", "isab/isak.def", "isab/isax.def", "jane", "jane/jank.def", "just", "just/jusk.def", "reap", "reap/reak.def", "teri", "teri/terk.def", "wall", "wall/walk.def", "sher", "sher/shek.def", "tsug", "tsug/tsuk.def", "goli", "goli/golk.def", "emic", "emic/emik.def", "necc", "necc/neck.def", "lucy", "lucy/luck.def", "gabb", "gabb/gabk.def", "tyra", "tyra/tyrx.def", "tyra/tyrk.def", "ajit/ajix.def", "lucy/lucx.def"}} then return end
end

if matchno() == 3 then
	if not launchFight{p2char = {"lucy/lucx.def"}} then return end
end

for i = matchno(), 5 do
	if not launchFight{exclude = {"ajit", "ajit/ajik.def", "baxt", "baxt/baxk.def", "bern", "bern/berk.def", "boun", "boun/bouk.def", "cici", "cici/cick.def", "ikue", "ikue/ikuk.def", "isab", "isab/isak.def", "isab/isax.def", "jane", "jane/jank.def", "just", "just/jusk.def", "reap", "reap/reak.def", "teri", "teri/terk.def", "wall", "wall/walk.def", "sher", "sher/shek.def", "tsug", "tsug/tsuk.def", "goli", "goli/golk.def", "emic", "emic/emik.def", "necc", "necc/neck.def", "lucy", "lucy/luck.def", "gabb", "gabb/gabk.def", "tyra", "tyra/tyrx.def", "tyra/tyrk.def", "ajit/ajix.def"}} then return end
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

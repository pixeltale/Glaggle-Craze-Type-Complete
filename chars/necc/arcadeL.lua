launchStoryboard('chars/necc/intro.def')

for i = matchno(), 2 do
	if not launchFight{exclude = {"ajit", "ajit/ajik.def", "baxt/baxk.def", "baxt", "bern/berk.def", "bern", "boun/bouk.def", "boun", "cici", "cici/cick.def", "ikue/ikuk.def", "ikue", "isab", "isab/isak.def", "isab/isax.def", "jane/jank.def", "jane", "just/jusk.def", "just", "reap/reak.def", "reap", "teri", "teri/terk.def", "wall/walk.def", "wall", "sher/shek.def", "sher", "tsug/tsuk.def", "tsug", "goli/golk.def", "goli", "emic", "emic/emik.def", "necc", "necc/neck.def", "lucy", "lucy/luck.def", "gabb", "gabb/gabk.def", "tyra", "tyra/tyrx.def", "tyra/tyrk.def", "wall/walx.def", "lucy/lucx.def"}} then return end
end

if matchno() == 3 then
	if not launchFight{p2char = {"wall/walx.def"}} then return end
end

for i = matchno(), 5 do
	if not launchFight{exclude = {"ajit", "ajit/ajik.def", "baxt/baxk.def", "baxt", "bern/berk.def", "bern", "boun/bouk.def", "boun", "cici", "cici/cick.def", "ikue/ikuk.def", "ikue", "isab", "isab/isak.def", "isab/isax.def", "jane/jank.def", "jane", "just/jusk.def", "just", "reap/reak.def", "reap", "teri", "teri/terk.def", "wall/walk.def", "wall", "sher/shek.def", "sher", "tsug/tsuk.def", "tsug", "goli/golk.def", "goli", "emic", "emic/emik.def", "necc", "necc/neck.def", "lucy", "lucy/luck.def", "gabb", "gabb/gabk.def", "tyra", "tyra/tyrx.def", "tyra/tyrk.def", "lucy/lucx.def"}} then return end
end

if matchno() == 6 then
	if not launchFight{p2char = {"lucy/lucx.def"}} then return end
end

if matchno() == 7 then
	if not launchFight{p2char = {"isab/isax.def"}} then return end
end

if matchno() == 8 then
	if not launchFight{p2char = {"tyra/tyrx.def"}} then return end
end

setMatchNo(-1)
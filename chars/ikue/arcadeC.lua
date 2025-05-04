launchStoryboard('chars/ikue/intro.def')

for i = matchno(), 2 do
	if not launchFight{exclude = {"ajit/ajix.def", "ajit/ajik.def", "baxt/baxk.def", "baxt/baxx.def", "bern/berk.def", "bern/berx.def", "boun/bouk.def", "boun/boux.def", "cici/cicx.def", "cici/cick.def", "ikue/ikuk.def", "ikue/ikux.def", "isab", "isab/isak.def", "isab/isax.def", "jane/jank.def", "jane/janx.def", "just/jusk.def", "just/jusx.def", "reap/reak.def", "reap/reax.def", "teri/terx.def", "teri/terk.def", "wall/walk.def", "wall/walx.def", "sher/shek.def", "sher/shex.def", "tsug/tsuk.def", "tsug/tsux.def", "goli/golk.def", "goli/golx.def", "emic/emix.def", "emic/emik.def", "necc/necx.def", "necc/neck.def", "lucy/lucx.def", "lucy/luck.def", "gabb/gabx.def", "gabb/gabk.def", "tyra", "tyra/tyrx.def", "tyra/tyrk.def", "ajit", "teri"}} then return end
end

if matchno() == 3 then
	if not launchFight{p2char = {"ajit"}} then return end
end

for i = matchno(), 5 do
	if not launchFight{exclude = {"ajit/ajix.def", "ajit/ajik.def", "baxt/baxk.def", "baxt/baxx.def", "bern/berk.def", "bern/berx.def", "boun/bouk.def", "boun/boux.def", "cici/cicx.def", "cici/cick.def", "ikue/ikuk.def", "ikue/ikux.def", "isab", "isab/isak.def", "isab/isax.def", "jane/jank.def", "jane/janx.def", "just/jusk.def", "just/jusx.def", "reap/reak.def", "reap/reax.def", "teri/terx.def", "teri/terk.def", "wall/walk.def", "wall/walx.def", "sher/shek.def", "sher/shex.def", "tsug/tsuk.def", "tsug/tsux.def", "goli/golk.def", "goli/golx.def", "emic/emix.def", "emic/emik.def", "necc/necx.def", "necc/neck.def", "lucy/lucx.def", "lucy/luck.def", "gabb/gabx.def", "gabb/gabk.def", "tyra", "tyra/tyrx.def", "tyra/tyrk.def", "teri"}} then return end
end

if matchno() == 6 then
	if not launchFight{p2char = {"teri"}} then return end
end

if matchno() == 7 then
	if not launchFight{p2char = {"isab"}} then return end
end

if matchno() == 8 then
	if not launchFight{p2char = {"tyra"}} then return end
end

setMatchNo(-1)

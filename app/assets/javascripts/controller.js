function changeModel(prefs)
{
    semprefs = document.getElementById("semprefs")
    comprefs = document.getElementById("comprefs")
    if (prefs)
    {
	semprefs.className = "hidden"
	comprefs.className = "modelo"
    }
    else
    {
	semprefs.className = "modelo"
	comprefs.className = "hidden"
    }

}
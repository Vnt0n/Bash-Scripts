#!/bin/bash
/Applications/UTM.app/Contents/MacOS/utmctl start "Parrot OS Security"
sleep 2  # Laisser le temps à UTM de s'ouvrir

# Mettre UTM au premier plan
osascript -e 'tell application "UTM" to activate'
sleep 0.5  # Pause pour s'assurer que le focus est pris

# Trouver et minimiser uniquement la fenêtre principale d'UTM en vérifiant le titre
osascript -e '
tell application "System Events"
    tell process "UTM"
        repeat with w in windows
            try
                if (name of w contains "UTM") then  -- Vérifie si le titre de la fenêtre contient "UTM"
                    set value of attribute "AXMinimized" of w to true
                    exit repeat  -- On arrête après avoir trouvé la bonne fenêtre
                end if
            end try
        end repeat
    end tell
end tell'


# Maximiser la fenêtre de la VM
osascript -e '
tell application "System Events"
    tell process "UTM"
        repeat with w in windows
            try
                if (name of w contains "Parrot OS Security") then  -- Vérifie si le titre de la fenêtre contient "Parrot Security"
                    set value of attribute "AXFullScreen" of w to true  -- Maximiser la fenêtre
                    exit repeat  -- On arrête après avoir trouvé la fenêtre de la VM
                end if
            end try
        end repeat
    end tell
end tell'

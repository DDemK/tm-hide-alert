bool prevGhostsVisible = false;
int prevOpponentsVisible = -1;


void Main(){
    prevGhostsVisible = GetGhostVisibility();
    prevOpponentsVisible = GetOpponentsVisibility();
}

void Update(float dt){
    auto visState = VehicleState::ViewingPlayerState();
    if (visState is null) {
        return;
    }
    auto ghostsVisible = GetGhostVisibility();
    if(ghostsVisible != prevGhostsVisible){
        OnGhostsVisChanged(ghostsVisible);
    }

    auto OpponentsVisible = GetOpponentsVisibility();
     if (OpponentsVisible != prevOpponentsVisible) {
        OnOpponentsVisChanged(OpponentsVisible);
     }
}

void OnGhostsVisChanged(bool ghostState){
    prevGhostsVisible = ghostState;
    if(ghostState){        
        vec4 color = vec4(0,0.75,0,0);
        UI::ShowNotification(Icons::CheckCircleO + " Hide Alert",
        "Ghosts are now enabled.", color, 3000);
    } else {        
        vec4 color = vec4(1,0,0,1);
        UI::ShowNotification(Icons::TimesCircleO + " Hide Alert",
        "Ghosts are now disabled.", color, 3000);
    }
}

void OnOpponentsVisChanged(OpponentsVisibility OpponentsState){
    prevOpponentsVisible = OpponentsState;
    vec4 color;
    switch(OpponentsState){
        case Off:
            color = vec4(1,0,0,1);
            UI::ShowNotification(Icons::TimesCircleO + " Hide Alert",
            "Opponents are now disabled.", color, 3000);
            break;
        case Transparent:
            color = vec4(0.75,0.75,0,1);
            UI::ShowNotification(Icons::CheckCircleO + " Hide Alert",
            "Opponents are now partially visible.", color, 3000);
            break;
        case Opaque:
            color = vec4(0,0.75,0,1);
            UI::ShowNotification(Icons::CheckCircle + " Hide Alert",
            "Opponents are now fully visible.", color, 3000);
            break;
    }
}
// ! From Autohide Opponents

/**
 * offsets for special user profile and user profile wrapper
 *
 * 2023-03-28: {rootMapM.Offset + 0x48, 0, 0x20, 0xA8}, {.., .., 0x18, 0x98}
 * 2023-04-28: {rootMapM.Offset + 0x48, 0, 0x28, 0xA8}, {.., .., 0x20, 0x98}
 *
 * For special interface UI
 *
 * 2023-03-28: app.Network, 0x158, (Names: 0x28, UI: 0x1c, 0x3c, 0x40)
 *
 */
// user profile
uint GhostVisOffset = 0xA8;
// user profile wrapper
uint OpponentVisOffset = 0xA8; // updated 2022-11-21

// updated 2023-04-28: +0x8 to both.
uint SpecialUserProfileWrapperOffset = 0x20;


enum OpponentsVisibility { Off = 0, Transparent = 1, Opaque = 2 };

CGameUserProfileWrapper@ GetSpecialUserProfileWrapper(CGameCtnApp@ app) {
    auto appTy = Reflection::GetType("CTrackMania");
    auto rootMapM = appTy.GetMember("RootMap");
    // orig 0x3a0
    auto off1 = rootMapM.Offset + 0x48;
    int[] offsets = {off1, 0, SpecialUserProfileWrapperOffset, OpponentVisOffset};
    auto fakeNod1 = Dev::GetOffsetNod(app, offsets[0]);
    auto fakeNod2 = Dev::GetOffsetNod(fakeNod1, offsets[1]);
    auto nod3 = Dev::GetOffsetNod(fakeNod2, offsets[2]);
    return cast<CGameUserProfileWrapper>(nod3);
}

CGameUserProfile@ GetSpecialUserProfile(CGameCtnApp@ app) {
    try {
        return GetSpecialUserProfileWrapper(app).ProfileNew;
    } catch {}
    return null;
}

bool GetGhostVisibility() {
    return Dev::GetOffsetUint32(GetSpecialUserProfile(GetApp()), GhostVisOffset) == 1;
}

OpponentsVisibility GetOpponentsVisibility() {
    return OpponentsVisibility(Dev::GetOffsetUint32(GetSpecialUserProfileWrapper(GetApp()), OpponentVisOffset));
}
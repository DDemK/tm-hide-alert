// user profile
uint GhostVisOffset = 0xA8;
uint SecondaryNameTagVisOffset = 0xC4;
// user profile wrapper
uint OpponentVisOffset = 0xA8; // updated 2022-11-21
// interface UI
uint UIVisOffset = 0x3c;
uint UIVisKeyOffset = 0x1c;
// updated 2023-04-28: +0x8 to both.
uint SpecialUserProfileWrapperOffset = 0x20;
uint SpecialUserProfileOffset = 0x28;

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
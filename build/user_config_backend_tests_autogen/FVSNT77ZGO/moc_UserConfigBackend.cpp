/****************************************************************************
** Meta object code from reading C++ file 'UserConfigBackend.h'
**
** Created by: The Qt Meta Object Compiler version 69 (Qt 6.11.1)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../backend/UserConfigBackend.h"
#include <QtCore/qmetatype.h>

#include <QtCore/qtmochelpers.h>

#include <memory>


#include <QtCore/qxptype_traits.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'UserConfigBackend.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 69
#error "This file was generated using the moc from 6.11.1. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

#ifndef Q_CONSTINIT
#define Q_CONSTINIT
#endif

QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
QT_WARNING_DISABLE_GCC("-Wuseless-cast")
namespace {
struct qt_meta_tag_ZN17UserConfigBackendE_t {};
} // unnamed namespace

template <> constexpr inline auto UserConfigBackend::qt_create_metaobjectdata<qt_meta_tag_ZN17UserConfigBackendE_t>()
{
    namespace QMC = QtMocConstants;
    QtMocHelpers::StringRefStorage qt_stringData {
        "UserConfigBackend",
        "QML.Element",
        "UserConfig",
        "QML.Singleton",
        "true",
        "configErrorChanged",
        "",
        "defaultWallpaperPathChanged",
        "defaultTlpSudoPasswordChanged",
        "wallpaperPathChanged",
        "iconFontFamilyChanged",
        "textFontFamilyChanged",
        "heroFontFamilyChanged",
        "timeFontFamilyChanged",
        "tlpSudoPasswordChanged",
        "tlpPermissionModeChanged",
        "overviewGlobalShortcutAppidChanged",
        "overviewGlobalShortcutNameChanged",
        "workspaceOverviewWindowDragButtonChanged",
        "dynamicIslandPrimaryButtonChanged",
        "dynamicIslandPrimaryActionChanged",
        "dynamicIslandSecondaryButtonChanged",
        "dynamicIslandSecondaryActionChanged",
        "dynamicIslandLeftSwipeItemsChanged",
        "disableAutoExpandOnTrackChangeChanged",
        "islandWidthChanged",
        "islandHeightChanged",
        "islandPositionXChanged",
        "bodyFontSizeChanged",
        "titleFontSizeChanged",
        "iconFontSizeChanged",
        "mouseButton",
        "QVariant",
        "button",
        "mouseButtonsMask",
        "buttons",
        "reload",
        "userConfigPath",
        "configError",
        "defaultWallpaperPath",
        "defaultTlpSudoPassword",
        "wallpaperPath",
        "iconFontFamily",
        "textFontFamily",
        "heroFontFamily",
        "timeFontFamily",
        "tlpSudoPassword",
        "tlpPermissionMode",
        "overviewGlobalShortcutAppid",
        "overviewGlobalShortcutName",
        "workspaceOverviewWindowDragButton",
        "dynamicIslandPrimaryButton",
        "dynamicIslandPrimaryAction",
        "dynamicIslandSecondaryButton",
        "dynamicIslandSecondaryAction",
        "dynamicIslandLeftSwipeItems",
        "QVariantList",
        "disableAutoExpandOnTrackChange",
        "islandWidth",
        "islandHeight",
        "islandPositionX",
        "bodyFontSize",
        "titleFontSize",
        "iconFontSize"
    };

    QtMocHelpers::UintData qt_methods {
        // Signal 'configErrorChanged'
        QtMocHelpers::SignalData<void()>(5, 6, QMC::AccessPublic, QMetaType::Void),
        // Signal 'defaultWallpaperPathChanged'
        QtMocHelpers::SignalData<void()>(7, 6, QMC::AccessPublic, QMetaType::Void),
        // Signal 'defaultTlpSudoPasswordChanged'
        QtMocHelpers::SignalData<void()>(8, 6, QMC::AccessPublic, QMetaType::Void),
        // Signal 'wallpaperPathChanged'
        QtMocHelpers::SignalData<void()>(9, 6, QMC::AccessPublic, QMetaType::Void),
        // Signal 'iconFontFamilyChanged'
        QtMocHelpers::SignalData<void()>(10, 6, QMC::AccessPublic, QMetaType::Void),
        // Signal 'textFontFamilyChanged'
        QtMocHelpers::SignalData<void()>(11, 6, QMC::AccessPublic, QMetaType::Void),
        // Signal 'heroFontFamilyChanged'
        QtMocHelpers::SignalData<void()>(12, 6, QMC::AccessPublic, QMetaType::Void),
        // Signal 'timeFontFamilyChanged'
        QtMocHelpers::SignalData<void()>(13, 6, QMC::AccessPublic, QMetaType::Void),
        // Signal 'tlpSudoPasswordChanged'
        QtMocHelpers::SignalData<void()>(14, 6, QMC::AccessPublic, QMetaType::Void),
        // Signal 'tlpPermissionModeChanged'
        QtMocHelpers::SignalData<void()>(15, 6, QMC::AccessPublic, QMetaType::Void),
        // Signal 'overviewGlobalShortcutAppidChanged'
        QtMocHelpers::SignalData<void()>(16, 6, QMC::AccessPublic, QMetaType::Void),
        // Signal 'overviewGlobalShortcutNameChanged'
        QtMocHelpers::SignalData<void()>(17, 6, QMC::AccessPublic, QMetaType::Void),
        // Signal 'workspaceOverviewWindowDragButtonChanged'
        QtMocHelpers::SignalData<void()>(18, 6, QMC::AccessPublic, QMetaType::Void),
        // Signal 'dynamicIslandPrimaryButtonChanged'
        QtMocHelpers::SignalData<void()>(19, 6, QMC::AccessPublic, QMetaType::Void),
        // Signal 'dynamicIslandPrimaryActionChanged'
        QtMocHelpers::SignalData<void()>(20, 6, QMC::AccessPublic, QMetaType::Void),
        // Signal 'dynamicIslandSecondaryButtonChanged'
        QtMocHelpers::SignalData<void()>(21, 6, QMC::AccessPublic, QMetaType::Void),
        // Signal 'dynamicIslandSecondaryActionChanged'
        QtMocHelpers::SignalData<void()>(22, 6, QMC::AccessPublic, QMetaType::Void),
        // Signal 'dynamicIslandLeftSwipeItemsChanged'
        QtMocHelpers::SignalData<void()>(23, 6, QMC::AccessPublic, QMetaType::Void),
        // Signal 'disableAutoExpandOnTrackChangeChanged'
        QtMocHelpers::SignalData<void()>(24, 6, QMC::AccessPublic, QMetaType::Void),
        // Signal 'islandWidthChanged'
        QtMocHelpers::SignalData<void()>(25, 6, QMC::AccessPublic, QMetaType::Void),
        // Signal 'islandHeightChanged'
        QtMocHelpers::SignalData<void()>(26, 6, QMC::AccessPublic, QMetaType::Void),
        // Signal 'islandPositionXChanged'
        QtMocHelpers::SignalData<void()>(27, 6, QMC::AccessPublic, QMetaType::Void),
        // Signal 'bodyFontSizeChanged'
        QtMocHelpers::SignalData<void()>(28, 6, QMC::AccessPublic, QMetaType::Void),
        // Signal 'titleFontSizeChanged'
        QtMocHelpers::SignalData<void()>(29, 6, QMC::AccessPublic, QMetaType::Void),
        // Signal 'iconFontSizeChanged'
        QtMocHelpers::SignalData<void()>(30, 6, QMC::AccessPublic, QMetaType::Void),
        // Method 'mouseButton'
        QtMocHelpers::MethodData<int(const QVariant &) const>(31, 6, QMC::AccessPublic, QMetaType::Int, {{
            { 0x80000000 | 32, 33 },
        }}),
        // Method 'mouseButtonsMask'
        QtMocHelpers::MethodData<int(const QVariant &) const>(34, 6, QMC::AccessPublic, QMetaType::Int, {{
            { 0x80000000 | 32, 35 },
        }}),
        // Method 'reload'
        QtMocHelpers::MethodData<void()>(36, 6, QMC::AccessPublic, QMetaType::Void),
    };
    QtMocHelpers::UintData qt_properties {
        // property 'userConfigPath'
        QtMocHelpers::PropertyData<QString>(37, QMetaType::QString, QMC::DefaultPropertyFlags | QMC::Constant | QMC::Final),
        // property 'configError'
        QtMocHelpers::PropertyData<QString>(38, QMetaType::QString, QMC::DefaultPropertyFlags | QMC::Final, 0),
        // property 'defaultWallpaperPath'
        QtMocHelpers::PropertyData<QString>(39, QMetaType::QString, QMC::DefaultPropertyFlags | QMC::Writable | QMC::StdCppSet | QMC::Final, 1),
        // property 'defaultTlpSudoPassword'
        QtMocHelpers::PropertyData<QString>(40, QMetaType::QString, QMC::DefaultPropertyFlags | QMC::Writable | QMC::StdCppSet | QMC::Final, 2),
        // property 'wallpaperPath'
        QtMocHelpers::PropertyData<QString>(41, QMetaType::QString, QMC::DefaultPropertyFlags | QMC::Final, 3),
        // property 'iconFontFamily'
        QtMocHelpers::PropertyData<QString>(42, QMetaType::QString, QMC::DefaultPropertyFlags | QMC::Final, 4),
        // property 'textFontFamily'
        QtMocHelpers::PropertyData<QString>(43, QMetaType::QString, QMC::DefaultPropertyFlags | QMC::Final, 5),
        // property 'heroFontFamily'
        QtMocHelpers::PropertyData<QString>(44, QMetaType::QString, QMC::DefaultPropertyFlags | QMC::Final, 6),
        // property 'timeFontFamily'
        QtMocHelpers::PropertyData<QString>(45, QMetaType::QString, QMC::DefaultPropertyFlags | QMC::Final, 7),
        // property 'tlpSudoPassword'
        QtMocHelpers::PropertyData<QString>(46, QMetaType::QString, QMC::DefaultPropertyFlags | QMC::Final, 8),
        // property 'tlpPermissionMode'
        QtMocHelpers::PropertyData<QString>(47, QMetaType::QString, QMC::DefaultPropertyFlags | QMC::Final, 9),
        // property 'overviewGlobalShortcutAppid'
        QtMocHelpers::PropertyData<QString>(48, QMetaType::QString, QMC::DefaultPropertyFlags | QMC::Final, 10),
        // property 'overviewGlobalShortcutName'
        QtMocHelpers::PropertyData<QString>(49, QMetaType::QString, QMC::DefaultPropertyFlags | QMC::Final, 11),
        // property 'workspaceOverviewWindowDragButton'
        QtMocHelpers::PropertyData<int>(50, QMetaType::Int, QMC::DefaultPropertyFlags | QMC::Final, 12),
        // property 'dynamicIslandPrimaryButton'
        QtMocHelpers::PropertyData<int>(51, QMetaType::Int, QMC::DefaultPropertyFlags | QMC::Final, 13),
        // property 'dynamicIslandPrimaryAction'
        QtMocHelpers::PropertyData<QString>(52, QMetaType::QString, QMC::DefaultPropertyFlags | QMC::Final, 14),
        // property 'dynamicIslandSecondaryButton'
        QtMocHelpers::PropertyData<int>(53, QMetaType::Int, QMC::DefaultPropertyFlags | QMC::Final, 15),
        // property 'dynamicIslandSecondaryAction'
        QtMocHelpers::PropertyData<QString>(54, QMetaType::QString, QMC::DefaultPropertyFlags | QMC::Final, 16),
        // property 'dynamicIslandLeftSwipeItems'
        QtMocHelpers::PropertyData<QVariantList>(55, 0x80000000 | 56, QMC::DefaultPropertyFlags | QMC::EnumOrFlag | QMC::Final, 17),
        // property 'disableAutoExpandOnTrackChange'
        QtMocHelpers::PropertyData<bool>(57, QMetaType::Bool, QMC::DefaultPropertyFlags | QMC::Final, 18),
        // property 'islandWidth'
        QtMocHelpers::PropertyData<int>(58, QMetaType::Int, QMC::DefaultPropertyFlags | QMC::Final, 19),
        // property 'islandHeight'
        QtMocHelpers::PropertyData<int>(59, QMetaType::Int, QMC::DefaultPropertyFlags | QMC::Final, 20),
        // property 'islandPositionX'
        QtMocHelpers::PropertyData<int>(60, QMetaType::Int, QMC::DefaultPropertyFlags | QMC::Final, 21),
        // property 'bodyFontSize'
        QtMocHelpers::PropertyData<int>(61, QMetaType::Int, QMC::DefaultPropertyFlags | QMC::Final, 22),
        // property 'titleFontSize'
        QtMocHelpers::PropertyData<int>(62, QMetaType::Int, QMC::DefaultPropertyFlags | QMC::Final, 23),
        // property 'iconFontSize'
        QtMocHelpers::PropertyData<int>(63, QMetaType::Int, QMC::DefaultPropertyFlags | QMC::Final, 24),
    };
    QtMocHelpers::UintData qt_enums {
    };
    QtMocHelpers::UintData qt_constructors {};
    QtMocHelpers::ClassInfos qt_classinfo({
            {    1,    2 },
            {    3,    4 },
    });
    return QtMocHelpers::metaObjectData<UserConfigBackend, void>(QMC::MetaObjectFlag{}, qt_stringData,
            qt_methods, qt_properties, qt_enums, qt_constructors, qt_classinfo);
}
Q_CONSTINIT const QMetaObject UserConfigBackend::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_staticMetaObjectStaticContent<qt_meta_tag_ZN17UserConfigBackendE_t>.stringdata,
    qt_staticMetaObjectStaticContent<qt_meta_tag_ZN17UserConfigBackendE_t>.data,
    qt_static_metacall,
    nullptr,
    qt_staticMetaObjectRelocatingContent<qt_meta_tag_ZN17UserConfigBackendE_t>.metaTypes,
    nullptr
} };

void UserConfigBackend::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    auto *_t = static_cast<UserConfigBackend *>(_o);
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: _t->configErrorChanged(); break;
        case 1: _t->defaultWallpaperPathChanged(); break;
        case 2: _t->defaultTlpSudoPasswordChanged(); break;
        case 3: _t->wallpaperPathChanged(); break;
        case 4: _t->iconFontFamilyChanged(); break;
        case 5: _t->textFontFamilyChanged(); break;
        case 6: _t->heroFontFamilyChanged(); break;
        case 7: _t->timeFontFamilyChanged(); break;
        case 8: _t->tlpSudoPasswordChanged(); break;
        case 9: _t->tlpPermissionModeChanged(); break;
        case 10: _t->overviewGlobalShortcutAppidChanged(); break;
        case 11: _t->overviewGlobalShortcutNameChanged(); break;
        case 12: _t->workspaceOverviewWindowDragButtonChanged(); break;
        case 13: _t->dynamicIslandPrimaryButtonChanged(); break;
        case 14: _t->dynamicIslandPrimaryActionChanged(); break;
        case 15: _t->dynamicIslandSecondaryButtonChanged(); break;
        case 16: _t->dynamicIslandSecondaryActionChanged(); break;
        case 17: _t->dynamicIslandLeftSwipeItemsChanged(); break;
        case 18: _t->disableAutoExpandOnTrackChangeChanged(); break;
        case 19: _t->islandWidthChanged(); break;
        case 20: _t->islandHeightChanged(); break;
        case 21: _t->islandPositionXChanged(); break;
        case 22: _t->bodyFontSizeChanged(); break;
        case 23: _t->titleFontSizeChanged(); break;
        case 24: _t->iconFontSizeChanged(); break;
        case 25: { int _r = _t->mouseButton((*reinterpret_cast<std::add_pointer_t<QVariant>>(_a[1])));
            if (_a[0]) *reinterpret_cast<int*>(_a[0]) = std::move(_r); }  break;
        case 26: { int _r = _t->mouseButtonsMask((*reinterpret_cast<std::add_pointer_t<QVariant>>(_a[1])));
            if (_a[0]) *reinterpret_cast<int*>(_a[0]) = std::move(_r); }  break;
        case 27: _t->reload(); break;
        default: ;
        }
    }
    if (_c == QMetaObject::IndexOfMethod) {
        if (QtMocHelpers::indexOfMethod<void (UserConfigBackend::*)()>(_a, &UserConfigBackend::configErrorChanged, 0))
            return;
        if (QtMocHelpers::indexOfMethod<void (UserConfigBackend::*)()>(_a, &UserConfigBackend::defaultWallpaperPathChanged, 1))
            return;
        if (QtMocHelpers::indexOfMethod<void (UserConfigBackend::*)()>(_a, &UserConfigBackend::defaultTlpSudoPasswordChanged, 2))
            return;
        if (QtMocHelpers::indexOfMethod<void (UserConfigBackend::*)()>(_a, &UserConfigBackend::wallpaperPathChanged, 3))
            return;
        if (QtMocHelpers::indexOfMethod<void (UserConfigBackend::*)()>(_a, &UserConfigBackend::iconFontFamilyChanged, 4))
            return;
        if (QtMocHelpers::indexOfMethod<void (UserConfigBackend::*)()>(_a, &UserConfigBackend::textFontFamilyChanged, 5))
            return;
        if (QtMocHelpers::indexOfMethod<void (UserConfigBackend::*)()>(_a, &UserConfigBackend::heroFontFamilyChanged, 6))
            return;
        if (QtMocHelpers::indexOfMethod<void (UserConfigBackend::*)()>(_a, &UserConfigBackend::timeFontFamilyChanged, 7))
            return;
        if (QtMocHelpers::indexOfMethod<void (UserConfigBackend::*)()>(_a, &UserConfigBackend::tlpSudoPasswordChanged, 8))
            return;
        if (QtMocHelpers::indexOfMethod<void (UserConfigBackend::*)()>(_a, &UserConfigBackend::tlpPermissionModeChanged, 9))
            return;
        if (QtMocHelpers::indexOfMethod<void (UserConfigBackend::*)()>(_a, &UserConfigBackend::overviewGlobalShortcutAppidChanged, 10))
            return;
        if (QtMocHelpers::indexOfMethod<void (UserConfigBackend::*)()>(_a, &UserConfigBackend::overviewGlobalShortcutNameChanged, 11))
            return;
        if (QtMocHelpers::indexOfMethod<void (UserConfigBackend::*)()>(_a, &UserConfigBackend::workspaceOverviewWindowDragButtonChanged, 12))
            return;
        if (QtMocHelpers::indexOfMethod<void (UserConfigBackend::*)()>(_a, &UserConfigBackend::dynamicIslandPrimaryButtonChanged, 13))
            return;
        if (QtMocHelpers::indexOfMethod<void (UserConfigBackend::*)()>(_a, &UserConfigBackend::dynamicIslandPrimaryActionChanged, 14))
            return;
        if (QtMocHelpers::indexOfMethod<void (UserConfigBackend::*)()>(_a, &UserConfigBackend::dynamicIslandSecondaryButtonChanged, 15))
            return;
        if (QtMocHelpers::indexOfMethod<void (UserConfigBackend::*)()>(_a, &UserConfigBackend::dynamicIslandSecondaryActionChanged, 16))
            return;
        if (QtMocHelpers::indexOfMethod<void (UserConfigBackend::*)()>(_a, &UserConfigBackend::dynamicIslandLeftSwipeItemsChanged, 17))
            return;
        if (QtMocHelpers::indexOfMethod<void (UserConfigBackend::*)()>(_a, &UserConfigBackend::disableAutoExpandOnTrackChangeChanged, 18))
            return;
        if (QtMocHelpers::indexOfMethod<void (UserConfigBackend::*)()>(_a, &UserConfigBackend::islandWidthChanged, 19))
            return;
        if (QtMocHelpers::indexOfMethod<void (UserConfigBackend::*)()>(_a, &UserConfigBackend::islandHeightChanged, 20))
            return;
        if (QtMocHelpers::indexOfMethod<void (UserConfigBackend::*)()>(_a, &UserConfigBackend::islandPositionXChanged, 21))
            return;
        if (QtMocHelpers::indexOfMethod<void (UserConfigBackend::*)()>(_a, &UserConfigBackend::bodyFontSizeChanged, 22))
            return;
        if (QtMocHelpers::indexOfMethod<void (UserConfigBackend::*)()>(_a, &UserConfigBackend::titleFontSizeChanged, 23))
            return;
        if (QtMocHelpers::indexOfMethod<void (UserConfigBackend::*)()>(_a, &UserConfigBackend::iconFontSizeChanged, 24))
            return;
    }
    if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast<QString*>(_v) = _t->userConfigPath(); break;
        case 1: *reinterpret_cast<QString*>(_v) = _t->configError(); break;
        case 2: *reinterpret_cast<QString*>(_v) = _t->defaultWallpaperPath(); break;
        case 3: *reinterpret_cast<QString*>(_v) = _t->defaultTlpSudoPassword(); break;
        case 4: *reinterpret_cast<QString*>(_v) = _t->wallpaperPath(); break;
        case 5: *reinterpret_cast<QString*>(_v) = _t->iconFontFamily(); break;
        case 6: *reinterpret_cast<QString*>(_v) = _t->textFontFamily(); break;
        case 7: *reinterpret_cast<QString*>(_v) = _t->heroFontFamily(); break;
        case 8: *reinterpret_cast<QString*>(_v) = _t->timeFontFamily(); break;
        case 9: *reinterpret_cast<QString*>(_v) = _t->tlpSudoPassword(); break;
        case 10: *reinterpret_cast<QString*>(_v) = _t->tlpPermissionMode(); break;
        case 11: *reinterpret_cast<QString*>(_v) = _t->overviewGlobalShortcutAppid(); break;
        case 12: *reinterpret_cast<QString*>(_v) = _t->overviewGlobalShortcutName(); break;
        case 13: *reinterpret_cast<int*>(_v) = _t->workspaceOverviewWindowDragButton(); break;
        case 14: *reinterpret_cast<int*>(_v) = _t->dynamicIslandPrimaryButton(); break;
        case 15: *reinterpret_cast<QString*>(_v) = _t->dynamicIslandPrimaryAction(); break;
        case 16: *reinterpret_cast<int*>(_v) = _t->dynamicIslandSecondaryButton(); break;
        case 17: *reinterpret_cast<QString*>(_v) = _t->dynamicIslandSecondaryAction(); break;
        case 18: *reinterpret_cast<QVariantList*>(_v) = _t->dynamicIslandLeftSwipeItems(); break;
        case 19: *reinterpret_cast<bool*>(_v) = _t->disableAutoExpandOnTrackChange(); break;
        case 20: *reinterpret_cast<int*>(_v) = _t->islandWidth(); break;
        case 21: *reinterpret_cast<int*>(_v) = _t->islandHeight(); break;
        case 22: *reinterpret_cast<int*>(_v) = _t->islandPositionX(); break;
        case 23: *reinterpret_cast<int*>(_v) = _t->bodyFontSize(); break;
        case 24: *reinterpret_cast<int*>(_v) = _t->titleFontSize(); break;
        case 25: *reinterpret_cast<int*>(_v) = _t->iconFontSize(); break;
        default: break;
        }
    }
    if (_c == QMetaObject::WriteProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 2: _t->setDefaultWallpaperPath(*reinterpret_cast<QString*>(_v)); break;
        case 3: _t->setDefaultTlpSudoPassword(*reinterpret_cast<QString*>(_v)); break;
        default: break;
        }
    }
}

const QMetaObject *UserConfigBackend::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *UserConfigBackend::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_staticMetaObjectStaticContent<qt_meta_tag_ZN17UserConfigBackendE_t>.strings))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int UserConfigBackend::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 28)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 28;
    }
    if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 28)
            *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType();
        _id -= 28;
    }
    if (_c == QMetaObject::ReadProperty || _c == QMetaObject::WriteProperty
            || _c == QMetaObject::ResetProperty || _c == QMetaObject::BindableProperty
            || _c == QMetaObject::RegisterPropertyMetaType) {
        qt_static_metacall(this, _c, _id, _a);
        _id -= 26;
    }
    return _id;
}

// SIGNAL 0
void UserConfigBackend::configErrorChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}

// SIGNAL 1
void UserConfigBackend::defaultWallpaperPathChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 1, nullptr);
}

// SIGNAL 2
void UserConfigBackend::defaultTlpSudoPasswordChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 2, nullptr);
}

// SIGNAL 3
void UserConfigBackend::wallpaperPathChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 3, nullptr);
}

// SIGNAL 4
void UserConfigBackend::iconFontFamilyChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 4, nullptr);
}

// SIGNAL 5
void UserConfigBackend::textFontFamilyChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 5, nullptr);
}

// SIGNAL 6
void UserConfigBackend::heroFontFamilyChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 6, nullptr);
}

// SIGNAL 7
void UserConfigBackend::timeFontFamilyChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 7, nullptr);
}

// SIGNAL 8
void UserConfigBackend::tlpSudoPasswordChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 8, nullptr);
}

// SIGNAL 9
void UserConfigBackend::tlpPermissionModeChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 9, nullptr);
}

// SIGNAL 10
void UserConfigBackend::overviewGlobalShortcutAppidChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 10, nullptr);
}

// SIGNAL 11
void UserConfigBackend::overviewGlobalShortcutNameChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 11, nullptr);
}

// SIGNAL 12
void UserConfigBackend::workspaceOverviewWindowDragButtonChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 12, nullptr);
}

// SIGNAL 13
void UserConfigBackend::dynamicIslandPrimaryButtonChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 13, nullptr);
}

// SIGNAL 14
void UserConfigBackend::dynamicIslandPrimaryActionChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 14, nullptr);
}

// SIGNAL 15
void UserConfigBackend::dynamicIslandSecondaryButtonChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 15, nullptr);
}

// SIGNAL 16
void UserConfigBackend::dynamicIslandSecondaryActionChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 16, nullptr);
}

// SIGNAL 17
void UserConfigBackend::dynamicIslandLeftSwipeItemsChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 17, nullptr);
}

// SIGNAL 18
void UserConfigBackend::disableAutoExpandOnTrackChangeChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 18, nullptr);
}

// SIGNAL 19
void UserConfigBackend::islandWidthChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 19, nullptr);
}

// SIGNAL 20
void UserConfigBackend::islandHeightChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 20, nullptr);
}

// SIGNAL 21
void UserConfigBackend::islandPositionXChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 21, nullptr);
}

// SIGNAL 22
void UserConfigBackend::bodyFontSizeChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 22, nullptr);
}

// SIGNAL 23
void UserConfigBackend::titleFontSizeChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 23, nullptr);
}

// SIGNAL 24
void UserConfigBackend::iconFontSizeChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 24, nullptr);
}
QT_WARNING_POP

/****************************************************************************
** Meta object code from reading C++ file 'SystemServices.h'
**
** Created by: The Qt Meta Object Compiler version 69 (Qt 6.11.1)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../backend/SystemServices.h"
#include <QtCore/qmetatype.h>

#include <QtCore/qtmochelpers.h>

#include <memory>


#include <QtCore/qxptype_traits.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'SystemServices.h' doesn't include <QObject>."
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
struct qt_meta_tag_ZN14SystemServicesE_t {};
} // unnamed namespace

template <> constexpr inline auto SystemServices::qt_create_metaobjectdata<qt_meta_tag_ZN14SystemServicesE_t>()
{
    namespace QMC = QtMocConstants;
    QtMocHelpers::StringRefStorage qt_stringData {
        "SystemServices",
        "QML.Element",
        "auto",
        "QML.Singleton",
        "true",
        "screenRecordingActiveChanged",
        "",
        "hyprlandSnapshotReady",
        "requestId",
        "subject",
        "payloadJson",
        "errorString",
        "wallpaperThumbnailFinished",
        "sourcePath",
        "cachePath",
        "cacheAvailable",
        "updated",
        "brightnessSnapshotReady",
        "value",
        "brightnessSetFinished",
        "success",
        "volumeSnapshotReady",
        "muted",
        "volumeSetFinished",
        "systemStatsReady",
        "cpuUsage",
        "ramUsage",
        "tlpStateReady",
        "available",
        "profile",
        "output",
        "tlpSetFinished",
        "exitCode",
        "cavaLevelsChanged",
        "requestScreenRecordingSnapshot",
        "requestHyprlandSnapshot",
        "generateWallpaperThumbnail",
        "cacheDir",
        "targetWidth",
        "targetHeight",
        "quality",
        "requestBrightness",
        "setBrightness",
        "requestVolume",
        "setVolume",
        "requestSystemStats",
        "requestTlpState",
        "setTlpMode",
        "mode",
        "sudoPassword",
        "cancelTlpApply",
        "setCavaClientActive",
        "clientId",
        "active",
        "ensureSetupComplete",
        "shellDir",
        "screenRecordingActive",
        "cavaLevels",
        "QVariantList"
    };

    QtMocHelpers::UintData qt_methods {
        // Signal 'screenRecordingActiveChanged'
        QtMocHelpers::SignalData<void()>(5, 6, QMC::AccessPublic, QMetaType::Void),
        // Signal 'hyprlandSnapshotReady'
        QtMocHelpers::SignalData<void(const QString &, const QString &, const QString &, const QString &)>(7, 6, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::QString, 8 }, { QMetaType::QString, 9 }, { QMetaType::QString, 10 }, { QMetaType::QString, 11 },
        }}),
        // Signal 'wallpaperThumbnailFinished'
        QtMocHelpers::SignalData<void(const QString &, const QString &, bool, bool, const QString &)>(12, 6, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::QString, 13 }, { QMetaType::QString, 14 }, { QMetaType::Bool, 15 }, { QMetaType::Bool, 16 },
            { QMetaType::QString, 11 },
        }}),
        // Signal 'brightnessSnapshotReady'
        QtMocHelpers::SignalData<void(double, const QString &)>(17, 6, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::Double, 18 }, { QMetaType::QString, 11 },
        }}),
        // Signal 'brightnessSetFinished'
        QtMocHelpers::SignalData<void(double, bool, const QString &)>(19, 6, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::Double, 18 }, { QMetaType::Bool, 20 }, { QMetaType::QString, 11 },
        }}),
        // Signal 'volumeSnapshotReady'
        QtMocHelpers::SignalData<void(double, bool, const QString &)>(21, 6, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::Double, 18 }, { QMetaType::Bool, 22 }, { QMetaType::QString, 11 },
        }}),
        // Signal 'volumeSetFinished'
        QtMocHelpers::SignalData<void(double, bool, const QString &)>(23, 6, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::Double, 18 }, { QMetaType::Bool, 20 }, { QMetaType::QString, 11 },
        }}),
        // Signal 'systemStatsReady'
        QtMocHelpers::SignalData<void(double, double, const QString &)>(24, 6, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::Double, 25 }, { QMetaType::Double, 26 }, { QMetaType::QString, 11 },
        }}),
        // Signal 'tlpStateReady'
        QtMocHelpers::SignalData<void(bool, const QString &, const QString &, const QString &)>(27, 6, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::Bool, 28 }, { QMetaType::QString, 29 }, { QMetaType::QString, 30 }, { QMetaType::QString, 11 },
        }}),
        // Signal 'tlpSetFinished'
        QtMocHelpers::SignalData<void(bool, int, const QString &, const QString &)>(31, 6, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::Bool, 20 }, { QMetaType::Int, 32 }, { QMetaType::QString, 30 }, { QMetaType::QString, 11 },
        }}),
        // Signal 'cavaLevelsChanged'
        QtMocHelpers::SignalData<void()>(33, 6, QMC::AccessPublic, QMetaType::Void),
        // Method 'requestScreenRecordingSnapshot'
        QtMocHelpers::MethodData<void()>(34, 6, QMC::AccessPublic, QMetaType::Void),
        // Method 'requestHyprlandSnapshot'
        QtMocHelpers::MethodData<void(const QString &, const QString &)>(35, 6, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::QString, 8 }, { QMetaType::QString, 9 },
        }}),
        // Method 'generateWallpaperThumbnail'
        QtMocHelpers::MethodData<void(const QString &, const QString &, const QString &, int, int, int)>(36, 6, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::QString, 13 }, { QMetaType::QString, 14 }, { QMetaType::QString, 37 }, { QMetaType::Int, 38 },
            { QMetaType::Int, 39 }, { QMetaType::Int, 40 },
        }}),
        // Method 'requestBrightness'
        QtMocHelpers::MethodData<void()>(41, 6, QMC::AccessPublic, QMetaType::Void),
        // Method 'setBrightness'
        QtMocHelpers::MethodData<void(double)>(42, 6, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::Double, 18 },
        }}),
        // Method 'requestVolume'
        QtMocHelpers::MethodData<void()>(43, 6, QMC::AccessPublic, QMetaType::Void),
        // Method 'setVolume'
        QtMocHelpers::MethodData<void(double)>(44, 6, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::Double, 18 },
        }}),
        // Method 'requestSystemStats'
        QtMocHelpers::MethodData<void()>(45, 6, QMC::AccessPublic, QMetaType::Void),
        // Method 'requestTlpState'
        QtMocHelpers::MethodData<void()>(46, 6, QMC::AccessPublic, QMetaType::Void),
        // Method 'setTlpMode'
        QtMocHelpers::MethodData<void(const QString &, const QString &)>(47, 6, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::QString, 48 }, { QMetaType::QString, 49 },
        }}),
        // Method 'setTlpMode'
        QtMocHelpers::MethodData<void(const QString &)>(47, 6, QMC::AccessPublic | QMC::MethodCloned, QMetaType::Void, {{
            { QMetaType::QString, 48 },
        }}),
        // Method 'cancelTlpApply'
        QtMocHelpers::MethodData<void()>(50, 6, QMC::AccessPublic, QMetaType::Void),
        // Method 'setCavaClientActive'
        QtMocHelpers::MethodData<void(const QString &, bool)>(51, 6, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::QString, 52 }, { QMetaType::Bool, 53 },
        }}),
        // Method 'ensureSetupComplete'
        QtMocHelpers::MethodData<void(const QString &)>(54, 6, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::QString, 55 },
        }}),
    };
    QtMocHelpers::UintData qt_properties {
        // property 'screenRecordingActive'
        QtMocHelpers::PropertyData<bool>(56, QMetaType::Bool, QMC::DefaultPropertyFlags | QMC::Final, 0),
        // property 'cavaLevels'
        QtMocHelpers::PropertyData<QVariantList>(57, 0x80000000 | 58, QMC::DefaultPropertyFlags | QMC::EnumOrFlag | QMC::Final, 10),
    };
    QtMocHelpers::UintData qt_enums {
    };
    QtMocHelpers::UintData qt_constructors {};
    QtMocHelpers::ClassInfos qt_classinfo({
            {    1,    2 },
            {    3,    4 },
    });
    return QtMocHelpers::metaObjectData<SystemServices, void>(QMC::MetaObjectFlag{}, qt_stringData,
            qt_methods, qt_properties, qt_enums, qt_constructors, qt_classinfo);
}
Q_CONSTINIT const QMetaObject SystemServices::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_staticMetaObjectStaticContent<qt_meta_tag_ZN14SystemServicesE_t>.stringdata,
    qt_staticMetaObjectStaticContent<qt_meta_tag_ZN14SystemServicesE_t>.data,
    qt_static_metacall,
    nullptr,
    qt_staticMetaObjectRelocatingContent<qt_meta_tag_ZN14SystemServicesE_t>.metaTypes,
    nullptr
} };

void SystemServices::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    auto *_t = static_cast<SystemServices *>(_o);
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: _t->screenRecordingActiveChanged(); break;
        case 1: _t->hyprlandSnapshotReady((*reinterpret_cast<std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast<std::add_pointer_t<QString>>(_a[2])),(*reinterpret_cast<std::add_pointer_t<QString>>(_a[3])),(*reinterpret_cast<std::add_pointer_t<QString>>(_a[4]))); break;
        case 2: _t->wallpaperThumbnailFinished((*reinterpret_cast<std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast<std::add_pointer_t<QString>>(_a[2])),(*reinterpret_cast<std::add_pointer_t<bool>>(_a[3])),(*reinterpret_cast<std::add_pointer_t<bool>>(_a[4])),(*reinterpret_cast<std::add_pointer_t<QString>>(_a[5]))); break;
        case 3: _t->brightnessSnapshotReady((*reinterpret_cast<std::add_pointer_t<double>>(_a[1])),(*reinterpret_cast<std::add_pointer_t<QString>>(_a[2]))); break;
        case 4: _t->brightnessSetFinished((*reinterpret_cast<std::add_pointer_t<double>>(_a[1])),(*reinterpret_cast<std::add_pointer_t<bool>>(_a[2])),(*reinterpret_cast<std::add_pointer_t<QString>>(_a[3]))); break;
        case 5: _t->volumeSnapshotReady((*reinterpret_cast<std::add_pointer_t<double>>(_a[1])),(*reinterpret_cast<std::add_pointer_t<bool>>(_a[2])),(*reinterpret_cast<std::add_pointer_t<QString>>(_a[3]))); break;
        case 6: _t->volumeSetFinished((*reinterpret_cast<std::add_pointer_t<double>>(_a[1])),(*reinterpret_cast<std::add_pointer_t<bool>>(_a[2])),(*reinterpret_cast<std::add_pointer_t<QString>>(_a[3]))); break;
        case 7: _t->systemStatsReady((*reinterpret_cast<std::add_pointer_t<double>>(_a[1])),(*reinterpret_cast<std::add_pointer_t<double>>(_a[2])),(*reinterpret_cast<std::add_pointer_t<QString>>(_a[3]))); break;
        case 8: _t->tlpStateReady((*reinterpret_cast<std::add_pointer_t<bool>>(_a[1])),(*reinterpret_cast<std::add_pointer_t<QString>>(_a[2])),(*reinterpret_cast<std::add_pointer_t<QString>>(_a[3])),(*reinterpret_cast<std::add_pointer_t<QString>>(_a[4]))); break;
        case 9: _t->tlpSetFinished((*reinterpret_cast<std::add_pointer_t<bool>>(_a[1])),(*reinterpret_cast<std::add_pointer_t<int>>(_a[2])),(*reinterpret_cast<std::add_pointer_t<QString>>(_a[3])),(*reinterpret_cast<std::add_pointer_t<QString>>(_a[4]))); break;
        case 10: _t->cavaLevelsChanged(); break;
        case 11: _t->requestScreenRecordingSnapshot(); break;
        case 12: _t->requestHyprlandSnapshot((*reinterpret_cast<std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast<std::add_pointer_t<QString>>(_a[2]))); break;
        case 13: _t->generateWallpaperThumbnail((*reinterpret_cast<std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast<std::add_pointer_t<QString>>(_a[2])),(*reinterpret_cast<std::add_pointer_t<QString>>(_a[3])),(*reinterpret_cast<std::add_pointer_t<int>>(_a[4])),(*reinterpret_cast<std::add_pointer_t<int>>(_a[5])),(*reinterpret_cast<std::add_pointer_t<int>>(_a[6]))); break;
        case 14: _t->requestBrightness(); break;
        case 15: _t->setBrightness((*reinterpret_cast<std::add_pointer_t<double>>(_a[1]))); break;
        case 16: _t->requestVolume(); break;
        case 17: _t->setVolume((*reinterpret_cast<std::add_pointer_t<double>>(_a[1]))); break;
        case 18: _t->requestSystemStats(); break;
        case 19: _t->requestTlpState(); break;
        case 20: _t->setTlpMode((*reinterpret_cast<std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast<std::add_pointer_t<QString>>(_a[2]))); break;
        case 21: _t->setTlpMode((*reinterpret_cast<std::add_pointer_t<QString>>(_a[1]))); break;
        case 22: _t->cancelTlpApply(); break;
        case 23: _t->setCavaClientActive((*reinterpret_cast<std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast<std::add_pointer_t<bool>>(_a[2]))); break;
        case 24: _t->ensureSetupComplete((*reinterpret_cast<std::add_pointer_t<QString>>(_a[1]))); break;
        default: ;
        }
    }
    if (_c == QMetaObject::IndexOfMethod) {
        if (QtMocHelpers::indexOfMethod<void (SystemServices::*)()>(_a, &SystemServices::screenRecordingActiveChanged, 0))
            return;
        if (QtMocHelpers::indexOfMethod<void (SystemServices::*)(const QString & , const QString & , const QString & , const QString & )>(_a, &SystemServices::hyprlandSnapshotReady, 1))
            return;
        if (QtMocHelpers::indexOfMethod<void (SystemServices::*)(const QString & , const QString & , bool , bool , const QString & )>(_a, &SystemServices::wallpaperThumbnailFinished, 2))
            return;
        if (QtMocHelpers::indexOfMethod<void (SystemServices::*)(double , const QString & )>(_a, &SystemServices::brightnessSnapshotReady, 3))
            return;
        if (QtMocHelpers::indexOfMethod<void (SystemServices::*)(double , bool , const QString & )>(_a, &SystemServices::brightnessSetFinished, 4))
            return;
        if (QtMocHelpers::indexOfMethod<void (SystemServices::*)(double , bool , const QString & )>(_a, &SystemServices::volumeSnapshotReady, 5))
            return;
        if (QtMocHelpers::indexOfMethod<void (SystemServices::*)(double , bool , const QString & )>(_a, &SystemServices::volumeSetFinished, 6))
            return;
        if (QtMocHelpers::indexOfMethod<void (SystemServices::*)(double , double , const QString & )>(_a, &SystemServices::systemStatsReady, 7))
            return;
        if (QtMocHelpers::indexOfMethod<void (SystemServices::*)(bool , const QString & , const QString & , const QString & )>(_a, &SystemServices::tlpStateReady, 8))
            return;
        if (QtMocHelpers::indexOfMethod<void (SystemServices::*)(bool , int , const QString & , const QString & )>(_a, &SystemServices::tlpSetFinished, 9))
            return;
        if (QtMocHelpers::indexOfMethod<void (SystemServices::*)()>(_a, &SystemServices::cavaLevelsChanged, 10))
            return;
    }
    if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast<bool*>(_v) = _t->screenRecordingActive(); break;
        case 1: *reinterpret_cast<QVariantList*>(_v) = _t->cavaLevels(); break;
        default: break;
        }
    }
}

const QMetaObject *SystemServices::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *SystemServices::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_staticMetaObjectStaticContent<qt_meta_tag_ZN14SystemServicesE_t>.strings))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int SystemServices::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 25)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 25;
    }
    if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 25)
            *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType();
        _id -= 25;
    }
    if (_c == QMetaObject::ReadProperty || _c == QMetaObject::WriteProperty
            || _c == QMetaObject::ResetProperty || _c == QMetaObject::BindableProperty
            || _c == QMetaObject::RegisterPropertyMetaType) {
        qt_static_metacall(this, _c, _id, _a);
        _id -= 2;
    }
    return _id;
}

// SIGNAL 0
void SystemServices::screenRecordingActiveChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}

// SIGNAL 1
void SystemServices::hyprlandSnapshotReady(const QString & _t1, const QString & _t2, const QString & _t3, const QString & _t4)
{
    QMetaObject::activate<void>(this, &staticMetaObject, 1, nullptr, _t1, _t2, _t3, _t4);
}

// SIGNAL 2
void SystemServices::wallpaperThumbnailFinished(const QString & _t1, const QString & _t2, bool _t3, bool _t4, const QString & _t5)
{
    QMetaObject::activate<void>(this, &staticMetaObject, 2, nullptr, _t1, _t2, _t3, _t4, _t5);
}

// SIGNAL 3
void SystemServices::brightnessSnapshotReady(double _t1, const QString & _t2)
{
    QMetaObject::activate<void>(this, &staticMetaObject, 3, nullptr, _t1, _t2);
}

// SIGNAL 4
void SystemServices::brightnessSetFinished(double _t1, bool _t2, const QString & _t3)
{
    QMetaObject::activate<void>(this, &staticMetaObject, 4, nullptr, _t1, _t2, _t3);
}

// SIGNAL 5
void SystemServices::volumeSnapshotReady(double _t1, bool _t2, const QString & _t3)
{
    QMetaObject::activate<void>(this, &staticMetaObject, 5, nullptr, _t1, _t2, _t3);
}

// SIGNAL 6
void SystemServices::volumeSetFinished(double _t1, bool _t2, const QString & _t3)
{
    QMetaObject::activate<void>(this, &staticMetaObject, 6, nullptr, _t1, _t2, _t3);
}

// SIGNAL 7
void SystemServices::systemStatsReady(double _t1, double _t2, const QString & _t3)
{
    QMetaObject::activate<void>(this, &staticMetaObject, 7, nullptr, _t1, _t2, _t3);
}

// SIGNAL 8
void SystemServices::tlpStateReady(bool _t1, const QString & _t2, const QString & _t3, const QString & _t4)
{
    QMetaObject::activate<void>(this, &staticMetaObject, 8, nullptr, _t1, _t2, _t3, _t4);
}

// SIGNAL 9
void SystemServices::tlpSetFinished(bool _t1, int _t2, const QString & _t3, const QString & _t4)
{
    QMetaObject::activate<void>(this, &staticMetaObject, 9, nullptr, _t1, _t2, _t3, _t4);
}

// SIGNAL 10
void SystemServices::cavaLevelsChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 10, nullptr);
}
QT_WARNING_POP

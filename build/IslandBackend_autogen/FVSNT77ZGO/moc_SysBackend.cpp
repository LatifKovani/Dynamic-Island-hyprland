/****************************************************************************
** Meta object code from reading C++ file 'SysBackend.h'
**
** Created by: The Qt Meta Object Compiler version 69 (Qt 6.11.1)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../backend/SysBackend.h"
#include <QtCore/qmetatype.h>

#include <QtCore/qtmochelpers.h>

#include <memory>


#include <QtCore/qxptype_traits.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'SysBackend.h' doesn't include <QObject>."
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
struct qt_meta_tag_ZN10SysBackendE_t {};
} // unnamed namespace

template <> constexpr inline auto SysBackend::qt_create_metaobjectdata<qt_meta_tag_ZN10SysBackendE_t>()
{
    namespace QMC = QtMocConstants;
    QtMocHelpers::StringRefStorage qt_stringData {
        "SysBackend",
        "QML.Element",
        "auto",
        "QML.Singleton",
        "true",
        "workspaceChanged",
        "",
        "wsId",
        "brightnessChanged",
        "val",
        "volumeChanged",
        "volPercentage",
        "isMuted",
        "batteryCapacityChanged",
        "capacity",
        "batteryStatusChanged",
        "statusString",
        "batteryChanged",
        "bluetoothChanged",
        "isConnected",
        "lyricsCurrentLyricChanged",
        "lyricsIsSyncedChanged",
        "lyricsBackendStatusChanged",
        "handleHyprlandData",
        "handleVolumeEvent",
        "fetchCurrentVolume",
        "handleVolumeQueryFinished",
        "exitCode",
        "QProcess::ExitStatus",
        "exitStatus",
        "handleDefaultSinkQueryFinished",
        "handleBatteryMonitorEvent",
        "handleBatteryPropertiesChanged",
        "interfaceName",
        "QVariantMap",
        "changedProperties",
        "invalidatedProperties",
        "handleUpowerBatteryChanged",
        "updateBrightness",
        "updateBatterySysfs",
        "updateBatteryUpower",
        "startLyricsBackend",
        "handleLyricsReadyRead",
        "handleLyricsProcessStateChanged",
        "QProcess::ProcessState",
        "state",
        "handleLyricsProcessFinished",
        "handleLyricsProcessError",
        "QProcess::ProcessError",
        "error",
        "handleLyricsStderr",
        "batteryCapacity",
        "batteryStatus",
        "lyricsCurrentLyric",
        "lyricsIsSynced",
        "lyricsBackendStatus"
    };

    QtMocHelpers::UintData qt_methods {
        // Signal 'workspaceChanged'
        QtMocHelpers::SignalData<void(int)>(5, 6, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::Int, 7 },
        }}),
        // Signal 'brightnessChanged'
        QtMocHelpers::SignalData<void(double)>(8, 6, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::Double, 9 },
        }}),
        // Signal 'volumeChanged'
        QtMocHelpers::SignalData<void(int, bool)>(10, 6, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::Int, 11 }, { QMetaType::Bool, 12 },
        }}),
        // Signal 'batteryCapacityChanged'
        QtMocHelpers::SignalData<void(int)>(13, 6, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::Int, 14 },
        }}),
        // Signal 'batteryStatusChanged'
        QtMocHelpers::SignalData<void(const QString &)>(15, 6, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::QString, 16 },
        }}),
        // Signal 'batteryChanged'
        QtMocHelpers::SignalData<void(int, const QString &)>(17, 6, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::Int, 14 }, { QMetaType::QString, 16 },
        }}),
        // Signal 'bluetoothChanged'
        QtMocHelpers::SignalData<void(bool)>(18, 6, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::Bool, 19 },
        }}),
        // Signal 'lyricsCurrentLyricChanged'
        QtMocHelpers::SignalData<void()>(20, 6, QMC::AccessPublic, QMetaType::Void),
        // Signal 'lyricsIsSyncedChanged'
        QtMocHelpers::SignalData<void()>(21, 6, QMC::AccessPublic, QMetaType::Void),
        // Signal 'lyricsBackendStatusChanged'
        QtMocHelpers::SignalData<void()>(22, 6, QMC::AccessPublic, QMetaType::Void),
        // Slot 'handleHyprlandData'
        QtMocHelpers::SlotData<void()>(23, 6, QMC::AccessPrivate, QMetaType::Void),
        // Slot 'handleVolumeEvent'
        QtMocHelpers::SlotData<void()>(24, 6, QMC::AccessPrivate, QMetaType::Void),
        // Slot 'fetchCurrentVolume'
        QtMocHelpers::SlotData<void()>(25, 6, QMC::AccessPrivate, QMetaType::Void),
        // Slot 'handleVolumeQueryFinished'
        QtMocHelpers::SlotData<void(int, QProcess::ExitStatus)>(26, 6, QMC::AccessPrivate, QMetaType::Void, {{
            { QMetaType::Int, 27 }, { 0x80000000 | 28, 29 },
        }}),
        // Slot 'handleDefaultSinkQueryFinished'
        QtMocHelpers::SlotData<void(int, QProcess::ExitStatus)>(30, 6, QMC::AccessPrivate, QMetaType::Void, {{
            { QMetaType::Int, 27 }, { 0x80000000 | 28, 29 },
        }}),
        // Slot 'handleBatteryMonitorEvent'
        QtMocHelpers::SlotData<void()>(31, 6, QMC::AccessPrivate, QMetaType::Void),
        // Slot 'handleBatteryPropertiesChanged'
        QtMocHelpers::SlotData<void(const QString &, const QVariantMap &, const QStringList &)>(32, 6, QMC::AccessPrivate, QMetaType::Void, {{
            { QMetaType::QString, 33 }, { 0x80000000 | 34, 35 }, { QMetaType::QStringList, 36 },
        }}),
        // Slot 'handleUpowerBatteryChanged'
        QtMocHelpers::SlotData<void()>(37, 6, QMC::AccessPrivate, QMetaType::Void),
        // Slot 'updateBrightness'
        QtMocHelpers::SlotData<void()>(38, 6, QMC::AccessPrivate, QMetaType::Void),
        // Slot 'updateBatterySysfs'
        QtMocHelpers::SlotData<void()>(39, 6, QMC::AccessPrivate, QMetaType::Void),
        // Slot 'updateBatteryUpower'
        QtMocHelpers::SlotData<void()>(40, 6, QMC::AccessPrivate, QMetaType::Void),
        // Slot 'startLyricsBackend'
        QtMocHelpers::SlotData<void()>(41, 6, QMC::AccessPrivate, QMetaType::Void),
        // Slot 'handleLyricsReadyRead'
        QtMocHelpers::SlotData<void()>(42, 6, QMC::AccessPrivate, QMetaType::Void),
        // Slot 'handleLyricsProcessStateChanged'
        QtMocHelpers::SlotData<void(QProcess::ProcessState)>(43, 6, QMC::AccessPrivate, QMetaType::Void, {{
            { 0x80000000 | 44, 45 },
        }}),
        // Slot 'handleLyricsProcessFinished'
        QtMocHelpers::SlotData<void(int, QProcess::ExitStatus)>(46, 6, QMC::AccessPrivate, QMetaType::Void, {{
            { QMetaType::Int, 27 }, { 0x80000000 | 28, 29 },
        }}),
        // Slot 'handleLyricsProcessError'
        QtMocHelpers::SlotData<void(QProcess::ProcessError)>(47, 6, QMC::AccessPrivate, QMetaType::Void, {{
            { 0x80000000 | 48, 49 },
        }}),
        // Slot 'handleLyricsStderr'
        QtMocHelpers::SlotData<void()>(50, 6, QMC::AccessPrivate, QMetaType::Void),
    };
    QtMocHelpers::UintData qt_properties {
        // property 'batteryCapacity'
        QtMocHelpers::PropertyData<int>(51, QMetaType::Int, QMC::DefaultPropertyFlags | QMC::Final, 3),
        // property 'batteryStatus'
        QtMocHelpers::PropertyData<QString>(52, QMetaType::QString, QMC::DefaultPropertyFlags | QMC::Final, 4),
        // property 'lyricsCurrentLyric'
        QtMocHelpers::PropertyData<QString>(53, QMetaType::QString, QMC::DefaultPropertyFlags | QMC::Final, 7),
        // property 'lyricsIsSynced'
        QtMocHelpers::PropertyData<bool>(54, QMetaType::Bool, QMC::DefaultPropertyFlags | QMC::Final, 8),
        // property 'lyricsBackendStatus'
        QtMocHelpers::PropertyData<QString>(55, QMetaType::QString, QMC::DefaultPropertyFlags | QMC::Final, 9),
    };
    QtMocHelpers::UintData qt_enums {
    };
    QtMocHelpers::UintData qt_constructors {};
    QtMocHelpers::ClassInfos qt_classinfo({
            {    1,    2 },
            {    3,    4 },
    });
    return QtMocHelpers::metaObjectData<SysBackend, void>(QMC::MetaObjectFlag{}, qt_stringData,
            qt_methods, qt_properties, qt_enums, qt_constructors, qt_classinfo);
}
Q_CONSTINIT const QMetaObject SysBackend::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_staticMetaObjectStaticContent<qt_meta_tag_ZN10SysBackendE_t>.stringdata,
    qt_staticMetaObjectStaticContent<qt_meta_tag_ZN10SysBackendE_t>.data,
    qt_static_metacall,
    nullptr,
    qt_staticMetaObjectRelocatingContent<qt_meta_tag_ZN10SysBackendE_t>.metaTypes,
    nullptr
} };

void SysBackend::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    auto *_t = static_cast<SysBackend *>(_o);
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: _t->workspaceChanged((*reinterpret_cast<std::add_pointer_t<int>>(_a[1]))); break;
        case 1: _t->brightnessChanged((*reinterpret_cast<std::add_pointer_t<double>>(_a[1]))); break;
        case 2: _t->volumeChanged((*reinterpret_cast<std::add_pointer_t<int>>(_a[1])),(*reinterpret_cast<std::add_pointer_t<bool>>(_a[2]))); break;
        case 3: _t->batteryCapacityChanged((*reinterpret_cast<std::add_pointer_t<int>>(_a[1]))); break;
        case 4: _t->batteryStatusChanged((*reinterpret_cast<std::add_pointer_t<QString>>(_a[1]))); break;
        case 5: _t->batteryChanged((*reinterpret_cast<std::add_pointer_t<int>>(_a[1])),(*reinterpret_cast<std::add_pointer_t<QString>>(_a[2]))); break;
        case 6: _t->bluetoothChanged((*reinterpret_cast<std::add_pointer_t<bool>>(_a[1]))); break;
        case 7: _t->lyricsCurrentLyricChanged(); break;
        case 8: _t->lyricsIsSyncedChanged(); break;
        case 9: _t->lyricsBackendStatusChanged(); break;
        case 10: _t->handleHyprlandData(); break;
        case 11: _t->handleVolumeEvent(); break;
        case 12: _t->fetchCurrentVolume(); break;
        case 13: _t->handleVolumeQueryFinished((*reinterpret_cast<std::add_pointer_t<int>>(_a[1])),(*reinterpret_cast<std::add_pointer_t<QProcess::ExitStatus>>(_a[2]))); break;
        case 14: _t->handleDefaultSinkQueryFinished((*reinterpret_cast<std::add_pointer_t<int>>(_a[1])),(*reinterpret_cast<std::add_pointer_t<QProcess::ExitStatus>>(_a[2]))); break;
        case 15: _t->handleBatteryMonitorEvent(); break;
        case 16: _t->handleBatteryPropertiesChanged((*reinterpret_cast<std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast<std::add_pointer_t<QVariantMap>>(_a[2])),(*reinterpret_cast<std::add_pointer_t<QStringList>>(_a[3]))); break;
        case 17: _t->handleUpowerBatteryChanged(); break;
        case 18: _t->updateBrightness(); break;
        case 19: _t->updateBatterySysfs(); break;
        case 20: _t->updateBatteryUpower(); break;
        case 21: _t->startLyricsBackend(); break;
        case 22: _t->handleLyricsReadyRead(); break;
        case 23: _t->handleLyricsProcessStateChanged((*reinterpret_cast<std::add_pointer_t<QProcess::ProcessState>>(_a[1]))); break;
        case 24: _t->handleLyricsProcessFinished((*reinterpret_cast<std::add_pointer_t<int>>(_a[1])),(*reinterpret_cast<std::add_pointer_t<QProcess::ExitStatus>>(_a[2]))); break;
        case 25: _t->handleLyricsProcessError((*reinterpret_cast<std::add_pointer_t<QProcess::ProcessError>>(_a[1]))); break;
        case 26: _t->handleLyricsStderr(); break;
        default: ;
        }
    }
    if (_c == QMetaObject::IndexOfMethod) {
        if (QtMocHelpers::indexOfMethod<void (SysBackend::*)(int )>(_a, &SysBackend::workspaceChanged, 0))
            return;
        if (QtMocHelpers::indexOfMethod<void (SysBackend::*)(double )>(_a, &SysBackend::brightnessChanged, 1))
            return;
        if (QtMocHelpers::indexOfMethod<void (SysBackend::*)(int , bool )>(_a, &SysBackend::volumeChanged, 2))
            return;
        if (QtMocHelpers::indexOfMethod<void (SysBackend::*)(int )>(_a, &SysBackend::batteryCapacityChanged, 3))
            return;
        if (QtMocHelpers::indexOfMethod<void (SysBackend::*)(const QString & )>(_a, &SysBackend::batteryStatusChanged, 4))
            return;
        if (QtMocHelpers::indexOfMethod<void (SysBackend::*)(int , const QString & )>(_a, &SysBackend::batteryChanged, 5))
            return;
        if (QtMocHelpers::indexOfMethod<void (SysBackend::*)(bool )>(_a, &SysBackend::bluetoothChanged, 6))
            return;
        if (QtMocHelpers::indexOfMethod<void (SysBackend::*)()>(_a, &SysBackend::lyricsCurrentLyricChanged, 7))
            return;
        if (QtMocHelpers::indexOfMethod<void (SysBackend::*)()>(_a, &SysBackend::lyricsIsSyncedChanged, 8))
            return;
        if (QtMocHelpers::indexOfMethod<void (SysBackend::*)()>(_a, &SysBackend::lyricsBackendStatusChanged, 9))
            return;
    }
    if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast<int*>(_v) = _t->batteryCapacity(); break;
        case 1: *reinterpret_cast<QString*>(_v) = _t->batteryStatus(); break;
        case 2: *reinterpret_cast<QString*>(_v) = _t->lyricsCurrentLyric(); break;
        case 3: *reinterpret_cast<bool*>(_v) = _t->lyricsIsSynced(); break;
        case 4: *reinterpret_cast<QString*>(_v) = _t->lyricsBackendStatus(); break;
        default: break;
        }
    }
}

const QMetaObject *SysBackend::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *SysBackend::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_staticMetaObjectStaticContent<qt_meta_tag_ZN10SysBackendE_t>.strings))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int SysBackend::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 27)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 27;
    }
    if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 27)
            *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType();
        _id -= 27;
    }
    if (_c == QMetaObject::ReadProperty || _c == QMetaObject::WriteProperty
            || _c == QMetaObject::ResetProperty || _c == QMetaObject::BindableProperty
            || _c == QMetaObject::RegisterPropertyMetaType) {
        qt_static_metacall(this, _c, _id, _a);
        _id -= 5;
    }
    return _id;
}

// SIGNAL 0
void SysBackend::workspaceChanged(int _t1)
{
    QMetaObject::activate<void>(this, &staticMetaObject, 0, nullptr, _t1);
}

// SIGNAL 1
void SysBackend::brightnessChanged(double _t1)
{
    QMetaObject::activate<void>(this, &staticMetaObject, 1, nullptr, _t1);
}

// SIGNAL 2
void SysBackend::volumeChanged(int _t1, bool _t2)
{
    QMetaObject::activate<void>(this, &staticMetaObject, 2, nullptr, _t1, _t2);
}

// SIGNAL 3
void SysBackend::batteryCapacityChanged(int _t1)
{
    QMetaObject::activate<void>(this, &staticMetaObject, 3, nullptr, _t1);
}

// SIGNAL 4
void SysBackend::batteryStatusChanged(const QString & _t1)
{
    QMetaObject::activate<void>(this, &staticMetaObject, 4, nullptr, _t1);
}

// SIGNAL 5
void SysBackend::batteryChanged(int _t1, const QString & _t2)
{
    QMetaObject::activate<void>(this, &staticMetaObject, 5, nullptr, _t1, _t2);
}

// SIGNAL 6
void SysBackend::bluetoothChanged(bool _t1)
{
    QMetaObject::activate<void>(this, &staticMetaObject, 6, nullptr, _t1);
}

// SIGNAL 7
void SysBackend::lyricsCurrentLyricChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 7, nullptr);
}

// SIGNAL 8
void SysBackend::lyricsIsSyncedChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 8, nullptr);
}

// SIGNAL 9
void SysBackend::lyricsBackendStatusChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 9, nullptr);
}
QT_WARNING_POP

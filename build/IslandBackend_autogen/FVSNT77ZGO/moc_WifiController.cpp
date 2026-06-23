/****************************************************************************
** Meta object code from reading C++ file 'WifiController.h'
**
** Created by: The Qt Meta Object Compiler version 69 (Qt 6.11.1)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../backend/WifiController.h"
#include <QtCore/qmetatype.h>

#include <QtCore/qtmochelpers.h>

#include <memory>


#include <QtCore/qxptype_traits.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'WifiController.h' doesn't include <QObject>."
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
struct qt_meta_tag_ZN14WifiControllerE_t {};
} // unnamed namespace

template <> constexpr inline auto WifiController::qt_create_metaobjectdata<qt_meta_tag_ZN14WifiControllerE_t>()
{
    namespace QMC = QtMocConstants;
    QtMocHelpers::StringRefStorage qt_stringData {
        "WifiController",
        "QML.Element",
        "auto",
        "QML.Singleton",
        "true",
        "QML.Creatable",
        "false",
        "QML.UncreatableReason",
        "Singleton",
        "backendNameChanged",
        "",
        "supportedChanged",
        "readOnlyChanged",
        "availableChanged",
        "enabledChanged",
        "busyChanged",
        "scanningChanged",
        "currentSsidChanged",
        "statusTextChanged",
        "infoMessageChanged",
        "errorMessageChanged",
        "unsupportedReasonChanged",
        "handleNameOwnerChanged",
        "name",
        "oldOwner",
        "newOwner",
        "handleManagerPropertiesChanged",
        "interfaceName",
        "QVariantMap",
        "changedProperties",
        "invalidatedProperties",
        "handleDevicePropertiesChanged",
        "handleAccessPointAdded",
        "QDBusObjectPath",
        "accessPointPath",
        "handleAccessPointRemoved",
        "handleDeviceAdded",
        "devicePath",
        "handleDeviceRemoved",
        "handleIwdInterfacesAdded",
        "objectPath",
        "QDBusArgument",
        "interfacesAndProperties",
        "handleIwdInterfacesRemoved",
        "interfaces",
        "handleNewConnection",
        "connectionPath",
        "handleConnectionRemoved",
        "refreshState",
        "refreshNetworks",
        "rescan",
        "setEnabled",
        "enabled",
        "disconnectCurrent",
        "connectToNetwork",
        "ssid",
        "password",
        "clearMessages",
        "backendName",
        "supported",
        "readOnly",
        "available",
        "busy",
        "scanning",
        "currentSsid",
        "statusText",
        "infoMessage",
        "errorMessage",
        "unsupportedReason",
        "networks",
        "QAbstractItemModel*"
    };

    QtMocHelpers::UintData qt_methods {
        // Signal 'backendNameChanged'
        QtMocHelpers::SignalData<void()>(9, 10, QMC::AccessPublic, QMetaType::Void),
        // Signal 'supportedChanged'
        QtMocHelpers::SignalData<void()>(11, 10, QMC::AccessPublic, QMetaType::Void),
        // Signal 'readOnlyChanged'
        QtMocHelpers::SignalData<void()>(12, 10, QMC::AccessPublic, QMetaType::Void),
        // Signal 'availableChanged'
        QtMocHelpers::SignalData<void()>(13, 10, QMC::AccessPublic, QMetaType::Void),
        // Signal 'enabledChanged'
        QtMocHelpers::SignalData<void()>(14, 10, QMC::AccessPublic, QMetaType::Void),
        // Signal 'busyChanged'
        QtMocHelpers::SignalData<void()>(15, 10, QMC::AccessPublic, QMetaType::Void),
        // Signal 'scanningChanged'
        QtMocHelpers::SignalData<void()>(16, 10, QMC::AccessPublic, QMetaType::Void),
        // Signal 'currentSsidChanged'
        QtMocHelpers::SignalData<void()>(17, 10, QMC::AccessPublic, QMetaType::Void),
        // Signal 'statusTextChanged'
        QtMocHelpers::SignalData<void()>(18, 10, QMC::AccessPublic, QMetaType::Void),
        // Signal 'infoMessageChanged'
        QtMocHelpers::SignalData<void()>(19, 10, QMC::AccessPublic, QMetaType::Void),
        // Signal 'errorMessageChanged'
        QtMocHelpers::SignalData<void()>(20, 10, QMC::AccessPublic, QMetaType::Void),
        // Signal 'unsupportedReasonChanged'
        QtMocHelpers::SignalData<void()>(21, 10, QMC::AccessPublic, QMetaType::Void),
        // Slot 'handleNameOwnerChanged'
        QtMocHelpers::SlotData<void(const QString &, const QString &, const QString &)>(22, 10, QMC::AccessPrivate, QMetaType::Void, {{
            { QMetaType::QString, 23 }, { QMetaType::QString, 24 }, { QMetaType::QString, 25 },
        }}),
        // Slot 'handleManagerPropertiesChanged'
        QtMocHelpers::SlotData<void(const QString &, const QVariantMap &, const QStringList &)>(26, 10, QMC::AccessPrivate, QMetaType::Void, {{
            { QMetaType::QString, 27 }, { 0x80000000 | 28, 29 }, { QMetaType::QStringList, 30 },
        }}),
        // Slot 'handleDevicePropertiesChanged'
        QtMocHelpers::SlotData<void(const QString &, const QVariantMap &, const QStringList &)>(31, 10, QMC::AccessPrivate, QMetaType::Void, {{
            { QMetaType::QString, 27 }, { 0x80000000 | 28, 29 }, { QMetaType::QStringList, 30 },
        }}),
        // Slot 'handleAccessPointAdded'
        QtMocHelpers::SlotData<void(const QDBusObjectPath &)>(32, 10, QMC::AccessPrivate, QMetaType::Void, {{
            { 0x80000000 | 33, 34 },
        }}),
        // Slot 'handleAccessPointRemoved'
        QtMocHelpers::SlotData<void(const QDBusObjectPath &)>(35, 10, QMC::AccessPrivate, QMetaType::Void, {{
            { 0x80000000 | 33, 34 },
        }}),
        // Slot 'handleDeviceAdded'
        QtMocHelpers::SlotData<void(const QDBusObjectPath &)>(36, 10, QMC::AccessPrivate, QMetaType::Void, {{
            { 0x80000000 | 33, 37 },
        }}),
        // Slot 'handleDeviceRemoved'
        QtMocHelpers::SlotData<void(const QDBusObjectPath &)>(38, 10, QMC::AccessPrivate, QMetaType::Void, {{
            { 0x80000000 | 33, 37 },
        }}),
        // Slot 'handleIwdInterfacesAdded'
        QtMocHelpers::SlotData<void(const QDBusObjectPath &, const QDBusArgument &)>(39, 10, QMC::AccessPrivate, QMetaType::Void, {{
            { 0x80000000 | 33, 40 }, { 0x80000000 | 41, 42 },
        }}),
        // Slot 'handleIwdInterfacesRemoved'
        QtMocHelpers::SlotData<void(const QDBusObjectPath &, const QStringList &)>(43, 10, QMC::AccessPrivate, QMetaType::Void, {{
            { 0x80000000 | 33, 40 }, { QMetaType::QStringList, 44 },
        }}),
        // Slot 'handleNewConnection'
        QtMocHelpers::SlotData<void(const QDBusObjectPath &)>(45, 10, QMC::AccessPrivate, QMetaType::Void, {{
            { 0x80000000 | 33, 46 },
        }}),
        // Slot 'handleConnectionRemoved'
        QtMocHelpers::SlotData<void(const QDBusObjectPath &)>(47, 10, QMC::AccessPrivate, QMetaType::Void, {{
            { 0x80000000 | 33, 46 },
        }}),
        // Method 'refreshState'
        QtMocHelpers::MethodData<void()>(48, 10, QMC::AccessPublic, QMetaType::Void),
        // Method 'refreshNetworks'
        QtMocHelpers::MethodData<void(bool)>(49, 10, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::Bool, 50 },
        }}),
        // Method 'refreshNetworks'
        QtMocHelpers::MethodData<void()>(49, 10, QMC::AccessPublic | QMC::MethodCloned, QMetaType::Void),
        // Method 'setEnabled'
        QtMocHelpers::MethodData<void(bool)>(51, 10, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::Bool, 52 },
        }}),
        // Method 'disconnectCurrent'
        QtMocHelpers::MethodData<void()>(53, 10, QMC::AccessPublic, QMetaType::Void),
        // Method 'connectToNetwork'
        QtMocHelpers::MethodData<void(const QString &, const QString &)>(54, 10, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::QString, 55 }, { QMetaType::QString, 56 },
        }}),
        // Method 'connectToNetwork'
        QtMocHelpers::MethodData<void(const QString &)>(54, 10, QMC::AccessPublic | QMC::MethodCloned, QMetaType::Void, {{
            { QMetaType::QString, 55 },
        }}),
        // Method 'clearMessages'
        QtMocHelpers::MethodData<void()>(57, 10, QMC::AccessPublic, QMetaType::Void),
    };
    QtMocHelpers::UintData qt_properties {
        // property 'backendName'
        QtMocHelpers::PropertyData<QString>(58, QMetaType::QString, QMC::DefaultPropertyFlags, 0),
        // property 'supported'
        QtMocHelpers::PropertyData<bool>(59, QMetaType::Bool, QMC::DefaultPropertyFlags, 1),
        // property 'readOnly'
        QtMocHelpers::PropertyData<bool>(60, QMetaType::Bool, QMC::DefaultPropertyFlags, 2),
        // property 'available'
        QtMocHelpers::PropertyData<bool>(61, QMetaType::Bool, QMC::DefaultPropertyFlags, 3),
        // property 'enabled'
        QtMocHelpers::PropertyData<bool>(52, QMetaType::Bool, QMC::DefaultPropertyFlags, 4),
        // property 'busy'
        QtMocHelpers::PropertyData<bool>(62, QMetaType::Bool, QMC::DefaultPropertyFlags, 5),
        // property 'scanning'
        QtMocHelpers::PropertyData<bool>(63, QMetaType::Bool, QMC::DefaultPropertyFlags, 6),
        // property 'currentSsid'
        QtMocHelpers::PropertyData<QString>(64, QMetaType::QString, QMC::DefaultPropertyFlags, 7),
        // property 'statusText'
        QtMocHelpers::PropertyData<QString>(65, QMetaType::QString, QMC::DefaultPropertyFlags, 8),
        // property 'infoMessage'
        QtMocHelpers::PropertyData<QString>(66, QMetaType::QString, QMC::DefaultPropertyFlags, 9),
        // property 'errorMessage'
        QtMocHelpers::PropertyData<QString>(67, QMetaType::QString, QMC::DefaultPropertyFlags, 10),
        // property 'unsupportedReason'
        QtMocHelpers::PropertyData<QString>(68, QMetaType::QString, QMC::DefaultPropertyFlags, 11),
        // property 'networks'
        QtMocHelpers::PropertyData<QAbstractItemModel*>(69, 0x80000000 | 70, QMC::DefaultPropertyFlags | QMC::EnumOrFlag | QMC::Constant),
    };
    QtMocHelpers::UintData qt_enums {
    };
    QtMocHelpers::UintData qt_constructors {};
    QtMocHelpers::ClassInfos qt_classinfo({
            {    1,    2 },
            {    3,    4 },
            {    5,    6 },
            {    7,    8 },
    });
    return QtMocHelpers::metaObjectData<WifiController, void>(QMC::MetaObjectFlag{}, qt_stringData,
            qt_methods, qt_properties, qt_enums, qt_constructors, qt_classinfo);
}
Q_CONSTINIT const QMetaObject WifiController::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_staticMetaObjectStaticContent<qt_meta_tag_ZN14WifiControllerE_t>.stringdata,
    qt_staticMetaObjectStaticContent<qt_meta_tag_ZN14WifiControllerE_t>.data,
    qt_static_metacall,
    nullptr,
    qt_staticMetaObjectRelocatingContent<qt_meta_tag_ZN14WifiControllerE_t>.metaTypes,
    nullptr
} };

void WifiController::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    auto *_t = static_cast<WifiController *>(_o);
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: _t->backendNameChanged(); break;
        case 1: _t->supportedChanged(); break;
        case 2: _t->readOnlyChanged(); break;
        case 3: _t->availableChanged(); break;
        case 4: _t->enabledChanged(); break;
        case 5: _t->busyChanged(); break;
        case 6: _t->scanningChanged(); break;
        case 7: _t->currentSsidChanged(); break;
        case 8: _t->statusTextChanged(); break;
        case 9: _t->infoMessageChanged(); break;
        case 10: _t->errorMessageChanged(); break;
        case 11: _t->unsupportedReasonChanged(); break;
        case 12: _t->handleNameOwnerChanged((*reinterpret_cast<std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast<std::add_pointer_t<QString>>(_a[2])),(*reinterpret_cast<std::add_pointer_t<QString>>(_a[3]))); break;
        case 13: _t->handleManagerPropertiesChanged((*reinterpret_cast<std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast<std::add_pointer_t<QVariantMap>>(_a[2])),(*reinterpret_cast<std::add_pointer_t<QStringList>>(_a[3]))); break;
        case 14: _t->handleDevicePropertiesChanged((*reinterpret_cast<std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast<std::add_pointer_t<QVariantMap>>(_a[2])),(*reinterpret_cast<std::add_pointer_t<QStringList>>(_a[3]))); break;
        case 15: _t->handleAccessPointAdded((*reinterpret_cast<std::add_pointer_t<QDBusObjectPath>>(_a[1]))); break;
        case 16: _t->handleAccessPointRemoved((*reinterpret_cast<std::add_pointer_t<QDBusObjectPath>>(_a[1]))); break;
        case 17: _t->handleDeviceAdded((*reinterpret_cast<std::add_pointer_t<QDBusObjectPath>>(_a[1]))); break;
        case 18: _t->handleDeviceRemoved((*reinterpret_cast<std::add_pointer_t<QDBusObjectPath>>(_a[1]))); break;
        case 19: _t->handleIwdInterfacesAdded((*reinterpret_cast<std::add_pointer_t<QDBusObjectPath>>(_a[1])),(*reinterpret_cast<std::add_pointer_t<QDBusArgument>>(_a[2]))); break;
        case 20: _t->handleIwdInterfacesRemoved((*reinterpret_cast<std::add_pointer_t<QDBusObjectPath>>(_a[1])),(*reinterpret_cast<std::add_pointer_t<QStringList>>(_a[2]))); break;
        case 21: _t->handleNewConnection((*reinterpret_cast<std::add_pointer_t<QDBusObjectPath>>(_a[1]))); break;
        case 22: _t->handleConnectionRemoved((*reinterpret_cast<std::add_pointer_t<QDBusObjectPath>>(_a[1]))); break;
        case 23: _t->refreshState(); break;
        case 24: _t->refreshNetworks((*reinterpret_cast<std::add_pointer_t<bool>>(_a[1]))); break;
        case 25: _t->refreshNetworks(); break;
        case 26: _t->setEnabled((*reinterpret_cast<std::add_pointer_t<bool>>(_a[1]))); break;
        case 27: _t->disconnectCurrent(); break;
        case 28: _t->connectToNetwork((*reinterpret_cast<std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast<std::add_pointer_t<QString>>(_a[2]))); break;
        case 29: _t->connectToNetwork((*reinterpret_cast<std::add_pointer_t<QString>>(_a[1]))); break;
        case 30: _t->clearMessages(); break;
        default: ;
        }
    }
    if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        switch (_id) {
        default: *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType(); break;
        case 15:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType(); break;
            case 0:
                *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType::fromType< QDBusObjectPath >(); break;
            }
            break;
        case 16:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType(); break;
            case 0:
                *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType::fromType< QDBusObjectPath >(); break;
            }
            break;
        case 17:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType(); break;
            case 0:
                *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType::fromType< QDBusObjectPath >(); break;
            }
            break;
        case 18:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType(); break;
            case 0:
                *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType::fromType< QDBusObjectPath >(); break;
            }
            break;
        case 19:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType(); break;
            case 1:
                *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType::fromType< QDBusArgument >(); break;
            case 0:
                *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType::fromType< QDBusObjectPath >(); break;
            }
            break;
        case 20:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType(); break;
            case 0:
                *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType::fromType< QDBusObjectPath >(); break;
            }
            break;
        case 21:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType(); break;
            case 0:
                *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType::fromType< QDBusObjectPath >(); break;
            }
            break;
        case 22:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType(); break;
            case 0:
                *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType::fromType< QDBusObjectPath >(); break;
            }
            break;
        }
    }
    if (_c == QMetaObject::IndexOfMethod) {
        if (QtMocHelpers::indexOfMethod<void (WifiController::*)()>(_a, &WifiController::backendNameChanged, 0))
            return;
        if (QtMocHelpers::indexOfMethod<void (WifiController::*)()>(_a, &WifiController::supportedChanged, 1))
            return;
        if (QtMocHelpers::indexOfMethod<void (WifiController::*)()>(_a, &WifiController::readOnlyChanged, 2))
            return;
        if (QtMocHelpers::indexOfMethod<void (WifiController::*)()>(_a, &WifiController::availableChanged, 3))
            return;
        if (QtMocHelpers::indexOfMethod<void (WifiController::*)()>(_a, &WifiController::enabledChanged, 4))
            return;
        if (QtMocHelpers::indexOfMethod<void (WifiController::*)()>(_a, &WifiController::busyChanged, 5))
            return;
        if (QtMocHelpers::indexOfMethod<void (WifiController::*)()>(_a, &WifiController::scanningChanged, 6))
            return;
        if (QtMocHelpers::indexOfMethod<void (WifiController::*)()>(_a, &WifiController::currentSsidChanged, 7))
            return;
        if (QtMocHelpers::indexOfMethod<void (WifiController::*)()>(_a, &WifiController::statusTextChanged, 8))
            return;
        if (QtMocHelpers::indexOfMethod<void (WifiController::*)()>(_a, &WifiController::infoMessageChanged, 9))
            return;
        if (QtMocHelpers::indexOfMethod<void (WifiController::*)()>(_a, &WifiController::errorMessageChanged, 10))
            return;
        if (QtMocHelpers::indexOfMethod<void (WifiController::*)()>(_a, &WifiController::unsupportedReasonChanged, 11))
            return;
    }
    if (_c == QMetaObject::RegisterPropertyMetaType) {
        switch (_id) {
        default: *reinterpret_cast<int*>(_a[0]) = -1; break;
        case 12:
            *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< QAbstractItemModel* >(); break;
        }
    }
    if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast<QString*>(_v) = _t->backendName(); break;
        case 1: *reinterpret_cast<bool*>(_v) = _t->supported(); break;
        case 2: *reinterpret_cast<bool*>(_v) = _t->readOnly(); break;
        case 3: *reinterpret_cast<bool*>(_v) = _t->available(); break;
        case 4: *reinterpret_cast<bool*>(_v) = _t->enabled(); break;
        case 5: *reinterpret_cast<bool*>(_v) = _t->busy(); break;
        case 6: *reinterpret_cast<bool*>(_v) = _t->scanning(); break;
        case 7: *reinterpret_cast<QString*>(_v) = _t->currentSsid(); break;
        case 8: *reinterpret_cast<QString*>(_v) = _t->statusText(); break;
        case 9: *reinterpret_cast<QString*>(_v) = _t->infoMessage(); break;
        case 10: *reinterpret_cast<QString*>(_v) = _t->errorMessage(); break;
        case 11: *reinterpret_cast<QString*>(_v) = _t->unsupportedReason(); break;
        case 12: *reinterpret_cast<QAbstractItemModel**>(_v) = _t->networks(); break;
        default: break;
        }
    }
}

const QMetaObject *WifiController::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *WifiController::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_staticMetaObjectStaticContent<qt_meta_tag_ZN14WifiControllerE_t>.strings))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int WifiController::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 31)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 31;
    }
    if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 31)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 31;
    }
    if (_c == QMetaObject::ReadProperty || _c == QMetaObject::WriteProperty
            || _c == QMetaObject::ResetProperty || _c == QMetaObject::BindableProperty
            || _c == QMetaObject::RegisterPropertyMetaType) {
        qt_static_metacall(this, _c, _id, _a);
        _id -= 13;
    }
    return _id;
}

// SIGNAL 0
void WifiController::backendNameChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}

// SIGNAL 1
void WifiController::supportedChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 1, nullptr);
}

// SIGNAL 2
void WifiController::readOnlyChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 2, nullptr);
}

// SIGNAL 3
void WifiController::availableChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 3, nullptr);
}

// SIGNAL 4
void WifiController::enabledChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 4, nullptr);
}

// SIGNAL 5
void WifiController::busyChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 5, nullptr);
}

// SIGNAL 6
void WifiController::scanningChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 6, nullptr);
}

// SIGNAL 7
void WifiController::currentSsidChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 7, nullptr);
}

// SIGNAL 8
void WifiController::statusTextChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 8, nullptr);
}

// SIGNAL 9
void WifiController::infoMessageChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 9, nullptr);
}

// SIGNAL 10
void WifiController::errorMessageChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 10, nullptr);
}

// SIGNAL 11
void WifiController::unsupportedReasonChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 11, nullptr);
}
QT_WARNING_POP

/****************************************************************************
** Meta object code from reading C++ file 'BluetoothPairingAgent.h'
**
** Created by: The Qt Meta Object Compiler version 69 (Qt 6.11.1)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../backend/BluetoothPairingAgent.h"
#include <QtCore/qmetatype.h>

#include <QtCore/qtmochelpers.h>

#include <memory>


#include <QtCore/qxptype_traits.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'BluetoothPairingAgent.h' doesn't include <QObject>."
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
struct qt_meta_tag_ZN21BluetoothPairingAgentE_t {};
} // unnamed namespace

template <> constexpr inline auto BluetoothPairingAgent::qt_create_metaobjectdata<qt_meta_tag_ZN21BluetoothPairingAgentE_t>()
{
    namespace QMC = QtMocConstants;
    QtMocHelpers::StringRefStorage qt_stringData {
        "BluetoothPairingAgent",
        "QML.Element",
        "auto",
        "QML.Singleton",
        "true",
        "QML.Creatable",
        "false",
        "QML.UncreatableReason",
        "Singleton",
        "D-Bus Interface",
        "org.bluez.Agent1",
        "registeredChanged",
        "",
        "registrationErrorChanged",
        "requestChanged",
        "Release",
        "RequestPinCode",
        "QDBusObjectPath",
        "device",
        "DisplayPinCode",
        "pincode",
        "RequestPasskey",
        "DisplayPasskey",
        "passkey",
        "entered",
        "RequestConfirmation",
        "RequestAuthorization",
        "AuthorizeService",
        "uuid",
        "Cancel",
        "handleBluezNameOwnerChanged",
        "name",
        "oldOwner",
        "newOwner",
        "submitSecret",
        "secret",
        "confirmRequest",
        "rejectRequest",
        "cancelRequest",
        "registered",
        "registrationError",
        "requestActive",
        "requestKind",
        "requestRequiresInput",
        "requestNumericInput",
        "requestRequiresConfirmation",
        "devicePath",
        "deviceName",
        "promptTitle",
        "promptMessage",
        "displayedCode",
        "displayedEnteredCount"
    };

    QtMocHelpers::UintData qt_methods {
        // Signal 'registeredChanged'
        QtMocHelpers::SignalData<void()>(11, 12, QMC::AccessPublic, QMetaType::Void),
        // Signal 'registrationErrorChanged'
        QtMocHelpers::SignalData<void()>(13, 12, QMC::AccessPublic, QMetaType::Void),
        // Signal 'requestChanged'
        QtMocHelpers::SignalData<void()>(14, 12, QMC::AccessPublic, QMetaType::Void),
        // Slot 'Release'
        QtMocHelpers::SlotData<void()>(15, 12, QMC::AccessPublic, QMetaType::Void),
        // Slot 'RequestPinCode'
        QtMocHelpers::SlotData<QString(const QDBusObjectPath &)>(16, 12, QMC::AccessPublic, QMetaType::QString, {{
            { 0x80000000 | 17, 18 },
        }}),
        // Slot 'DisplayPinCode'
        QtMocHelpers::SlotData<void(const QDBusObjectPath &, const QString &)>(19, 12, QMC::AccessPublic, QMetaType::Void, {{
            { 0x80000000 | 17, 18 }, { QMetaType::QString, 20 },
        }}),
        // Slot 'RequestPasskey'
        QtMocHelpers::SlotData<uint(const QDBusObjectPath &)>(21, 12, QMC::AccessPublic, QMetaType::UInt, {{
            { 0x80000000 | 17, 18 },
        }}),
        // Slot 'DisplayPasskey'
        QtMocHelpers::SlotData<void(const QDBusObjectPath &, uint, ushort)>(22, 12, QMC::AccessPublic, QMetaType::Void, {{
            { 0x80000000 | 17, 18 }, { QMetaType::UInt, 23 }, { QMetaType::UShort, 24 },
        }}),
        // Slot 'RequestConfirmation'
        QtMocHelpers::SlotData<void(const QDBusObjectPath &, uint)>(25, 12, QMC::AccessPublic, QMetaType::Void, {{
            { 0x80000000 | 17, 18 }, { QMetaType::UInt, 23 },
        }}),
        // Slot 'RequestAuthorization'
        QtMocHelpers::SlotData<void(const QDBusObjectPath &)>(26, 12, QMC::AccessPublic, QMetaType::Void, {{
            { 0x80000000 | 17, 18 },
        }}),
        // Slot 'AuthorizeService'
        QtMocHelpers::SlotData<void(const QDBusObjectPath &, const QString &)>(27, 12, QMC::AccessPublic, QMetaType::Void, {{
            { 0x80000000 | 17, 18 }, { QMetaType::QString, 28 },
        }}),
        // Slot 'Cancel'
        QtMocHelpers::SlotData<void()>(29, 12, QMC::AccessPublic, QMetaType::Void),
        // Slot 'handleBluezNameOwnerChanged'
        QtMocHelpers::SlotData<void(const QString &, const QString &, const QString &)>(30, 12, QMC::AccessPrivate, QMetaType::Void, {{
            { QMetaType::QString, 31 }, { QMetaType::QString, 32 }, { QMetaType::QString, 33 },
        }}),
        // Method 'submitSecret'
        QtMocHelpers::MethodData<void(const QString &)>(34, 12, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::QString, 35 },
        }}),
        // Method 'confirmRequest'
        QtMocHelpers::MethodData<void()>(36, 12, QMC::AccessPublic, QMetaType::Void),
        // Method 'rejectRequest'
        QtMocHelpers::MethodData<void()>(37, 12, QMC::AccessPublic, QMetaType::Void),
        // Method 'cancelRequest'
        QtMocHelpers::MethodData<void()>(38, 12, QMC::AccessPublic, QMetaType::Void),
    };
    QtMocHelpers::UintData qt_properties {
        // property 'registered'
        QtMocHelpers::PropertyData<bool>(39, QMetaType::Bool, QMC::DefaultPropertyFlags, 0),
        // property 'registrationError'
        QtMocHelpers::PropertyData<QString>(40, QMetaType::QString, QMC::DefaultPropertyFlags, 1),
        // property 'requestActive'
        QtMocHelpers::PropertyData<bool>(41, QMetaType::Bool, QMC::DefaultPropertyFlags, 2),
        // property 'requestKind'
        QtMocHelpers::PropertyData<QString>(42, QMetaType::QString, QMC::DefaultPropertyFlags, 2),
        // property 'requestRequiresInput'
        QtMocHelpers::PropertyData<bool>(43, QMetaType::Bool, QMC::DefaultPropertyFlags, 2),
        // property 'requestNumericInput'
        QtMocHelpers::PropertyData<bool>(44, QMetaType::Bool, QMC::DefaultPropertyFlags, 2),
        // property 'requestRequiresConfirmation'
        QtMocHelpers::PropertyData<bool>(45, QMetaType::Bool, QMC::DefaultPropertyFlags, 2),
        // property 'devicePath'
        QtMocHelpers::PropertyData<QString>(46, QMetaType::QString, QMC::DefaultPropertyFlags, 2),
        // property 'deviceName'
        QtMocHelpers::PropertyData<QString>(47, QMetaType::QString, QMC::DefaultPropertyFlags, 2),
        // property 'promptTitle'
        QtMocHelpers::PropertyData<QString>(48, QMetaType::QString, QMC::DefaultPropertyFlags, 2),
        // property 'promptMessage'
        QtMocHelpers::PropertyData<QString>(49, QMetaType::QString, QMC::DefaultPropertyFlags, 2),
        // property 'displayedCode'
        QtMocHelpers::PropertyData<QString>(50, QMetaType::QString, QMC::DefaultPropertyFlags, 2),
        // property 'displayedEnteredCount'
        QtMocHelpers::PropertyData<int>(51, QMetaType::Int, QMC::DefaultPropertyFlags, 2),
    };
    QtMocHelpers::UintData qt_enums {
    };
    QtMocHelpers::UintData qt_constructors {};
    QtMocHelpers::ClassInfos qt_classinfo({
            {    1,    2 },
            {    3,    4 },
            {    5,    6 },
            {    7,    8 },
            {    9,   10 },
    });
    return QtMocHelpers::metaObjectData<BluetoothPairingAgent, void>(QMC::MetaObjectFlag{}, qt_stringData,
            qt_methods, qt_properties, qt_enums, qt_constructors, qt_classinfo);
}
Q_CONSTINIT const QMetaObject BluetoothPairingAgent::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_staticMetaObjectStaticContent<qt_meta_tag_ZN21BluetoothPairingAgentE_t>.stringdata,
    qt_staticMetaObjectStaticContent<qt_meta_tag_ZN21BluetoothPairingAgentE_t>.data,
    qt_static_metacall,
    nullptr,
    qt_staticMetaObjectRelocatingContent<qt_meta_tag_ZN21BluetoothPairingAgentE_t>.metaTypes,
    nullptr
} };

void BluetoothPairingAgent::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    auto *_t = static_cast<BluetoothPairingAgent *>(_o);
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: _t->registeredChanged(); break;
        case 1: _t->registrationErrorChanged(); break;
        case 2: _t->requestChanged(); break;
        case 3: _t->Release(); break;
        case 4: { QString _r = _t->RequestPinCode((*reinterpret_cast<std::add_pointer_t<QDBusObjectPath>>(_a[1])));
            if (_a[0]) *reinterpret_cast<QString*>(_a[0]) = std::move(_r); }  break;
        case 5: _t->DisplayPinCode((*reinterpret_cast<std::add_pointer_t<QDBusObjectPath>>(_a[1])),(*reinterpret_cast<std::add_pointer_t<QString>>(_a[2]))); break;
        case 6: { uint _r = _t->RequestPasskey((*reinterpret_cast<std::add_pointer_t<QDBusObjectPath>>(_a[1])));
            if (_a[0]) *reinterpret_cast<uint*>(_a[0]) = std::move(_r); }  break;
        case 7: _t->DisplayPasskey((*reinterpret_cast<std::add_pointer_t<QDBusObjectPath>>(_a[1])),(*reinterpret_cast<std::add_pointer_t<uint>>(_a[2])),(*reinterpret_cast<std::add_pointer_t<ushort>>(_a[3]))); break;
        case 8: _t->RequestConfirmation((*reinterpret_cast<std::add_pointer_t<QDBusObjectPath>>(_a[1])),(*reinterpret_cast<std::add_pointer_t<uint>>(_a[2]))); break;
        case 9: _t->RequestAuthorization((*reinterpret_cast<std::add_pointer_t<QDBusObjectPath>>(_a[1]))); break;
        case 10: _t->AuthorizeService((*reinterpret_cast<std::add_pointer_t<QDBusObjectPath>>(_a[1])),(*reinterpret_cast<std::add_pointer_t<QString>>(_a[2]))); break;
        case 11: _t->Cancel(); break;
        case 12: _t->handleBluezNameOwnerChanged((*reinterpret_cast<std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast<std::add_pointer_t<QString>>(_a[2])),(*reinterpret_cast<std::add_pointer_t<QString>>(_a[3]))); break;
        case 13: _t->submitSecret((*reinterpret_cast<std::add_pointer_t<QString>>(_a[1]))); break;
        case 14: _t->confirmRequest(); break;
        case 15: _t->rejectRequest(); break;
        case 16: _t->cancelRequest(); break;
        default: ;
        }
    }
    if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        switch (_id) {
        default: *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType(); break;
        case 4:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType(); break;
            case 0:
                *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType::fromType< QDBusObjectPath >(); break;
            }
            break;
        case 5:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType(); break;
            case 0:
                *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType::fromType< QDBusObjectPath >(); break;
            }
            break;
        case 6:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType(); break;
            case 0:
                *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType::fromType< QDBusObjectPath >(); break;
            }
            break;
        case 7:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType(); break;
            case 0:
                *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType::fromType< QDBusObjectPath >(); break;
            }
            break;
        case 8:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType(); break;
            case 0:
                *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType::fromType< QDBusObjectPath >(); break;
            }
            break;
        case 9:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType(); break;
            case 0:
                *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType::fromType< QDBusObjectPath >(); break;
            }
            break;
        case 10:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType(); break;
            case 0:
                *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType::fromType< QDBusObjectPath >(); break;
            }
            break;
        }
    }
    if (_c == QMetaObject::IndexOfMethod) {
        if (QtMocHelpers::indexOfMethod<void (BluetoothPairingAgent::*)()>(_a, &BluetoothPairingAgent::registeredChanged, 0))
            return;
        if (QtMocHelpers::indexOfMethod<void (BluetoothPairingAgent::*)()>(_a, &BluetoothPairingAgent::registrationErrorChanged, 1))
            return;
        if (QtMocHelpers::indexOfMethod<void (BluetoothPairingAgent::*)()>(_a, &BluetoothPairingAgent::requestChanged, 2))
            return;
    }
    if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast<bool*>(_v) = _t->registered(); break;
        case 1: *reinterpret_cast<QString*>(_v) = _t->registrationError(); break;
        case 2: *reinterpret_cast<bool*>(_v) = _t->requestActive(); break;
        case 3: *reinterpret_cast<QString*>(_v) = _t->requestKind(); break;
        case 4: *reinterpret_cast<bool*>(_v) = _t->requestRequiresInput(); break;
        case 5: *reinterpret_cast<bool*>(_v) = _t->requestNumericInput(); break;
        case 6: *reinterpret_cast<bool*>(_v) = _t->requestRequiresConfirmation(); break;
        case 7: *reinterpret_cast<QString*>(_v) = _t->devicePath(); break;
        case 8: *reinterpret_cast<QString*>(_v) = _t->deviceName(); break;
        case 9: *reinterpret_cast<QString*>(_v) = _t->promptTitle(); break;
        case 10: *reinterpret_cast<QString*>(_v) = _t->promptMessage(); break;
        case 11: *reinterpret_cast<QString*>(_v) = _t->displayedCode(); break;
        case 12: *reinterpret_cast<int*>(_v) = _t->displayedEnteredCount(); break;
        default: break;
        }
    }
}

const QMetaObject *BluetoothPairingAgent::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *BluetoothPairingAgent::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_staticMetaObjectStaticContent<qt_meta_tag_ZN21BluetoothPairingAgentE_t>.strings))
        return static_cast<void*>(this);
    if (!strcmp(_clname, "QDBusContext"))
        return static_cast< QDBusContext*>(this);
    return QObject::qt_metacast(_clname);
}

int BluetoothPairingAgent::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 17)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 17;
    }
    if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 17)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 17;
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
void BluetoothPairingAgent::registeredChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}

// SIGNAL 1
void BluetoothPairingAgent::registrationErrorChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 1, nullptr);
}

// SIGNAL 2
void BluetoothPairingAgent::requestChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 2, nullptr);
}
QT_WARNING_POP

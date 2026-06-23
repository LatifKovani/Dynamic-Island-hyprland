/****************************************************************************
** Meta object code from reading C++ file 'LyricsMprisApp.h'
**
** Created by: The Qt Meta Object Compiler version 69 (Qt 6.11.1)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../lyricsmpris/LyricsMprisApp.h"
#include <QtNetwork/QSslError>
#include <QtCore/qmetatype.h>

#include <QtCore/qtmochelpers.h>

#include <memory>


#include <QtCore/qxptype_traits.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'LyricsMprisApp.h' doesn't include <QObject>."
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
struct qt_meta_tag_ZN11lyricsmpris14LyricsMprisAppE_t {};
} // unnamed namespace

template <> constexpr inline auto lyricsmpris::LyricsMprisApp::qt_create_metaobjectdata<qt_meta_tag_ZN11lyricsmpris14LyricsMprisAppE_t>()
{
    namespace QMC = QtMocConstants;
    QtMocHelpers::StringRefStorage qt_stringData {
        "lyricsmpris::LyricsMprisApp",
        "start",
        "",
        "refreshPlayers",
        "handleNameOwnerChanged",
        "name",
        "oldOwner",
        "newOwner",
        "handlePropertiesChanged",
        "interfaceName",
        "QVariantMap",
        "changedProperties",
        "invalidatedProperties",
        "handleSeeked",
        "positionUs",
        "updatePosition",
        "startFallbackProviders",
        "handleNetworkFinished"
    };

    QtMocHelpers::UintData qt_methods {
        // Slot 'start'
        QtMocHelpers::SlotData<void()>(1, 2, QMC::AccessPublic, QMetaType::Void),
        // Slot 'refreshPlayers'
        QtMocHelpers::SlotData<void()>(3, 2, QMC::AccessPrivate, QMetaType::Void),
        // Slot 'handleNameOwnerChanged'
        QtMocHelpers::SlotData<void(const QString &, const QString &, const QString &)>(4, 2, QMC::AccessPrivate, QMetaType::Void, {{
            { QMetaType::QString, 5 }, { QMetaType::QString, 6 }, { QMetaType::QString, 7 },
        }}),
        // Slot 'handlePropertiesChanged'
        QtMocHelpers::SlotData<void(const QString &, const QVariantMap &, const QStringList &)>(8, 2, QMC::AccessPrivate, QMetaType::Void, {{
            { QMetaType::QString, 9 }, { 0x80000000 | 10, 11 }, { QMetaType::QStringList, 12 },
        }}),
        // Slot 'handleSeeked'
        QtMocHelpers::SlotData<void(qlonglong)>(13, 2, QMC::AccessPrivate, QMetaType::Void, {{
            { QMetaType::LongLong, 14 },
        }}),
        // Slot 'updatePosition'
        QtMocHelpers::SlotData<void()>(15, 2, QMC::AccessPrivate, QMetaType::Void),
        // Slot 'startFallbackProviders'
        QtMocHelpers::SlotData<void()>(16, 2, QMC::AccessPrivate, QMetaType::Void),
        // Slot 'handleNetworkFinished'
        QtMocHelpers::SlotData<void()>(17, 2, QMC::AccessPrivate, QMetaType::Void),
    };
    QtMocHelpers::UintData qt_properties {
    };
    QtMocHelpers::UintData qt_enums {
    };
    return QtMocHelpers::metaObjectData<LyricsMprisApp, qt_meta_tag_ZN11lyricsmpris14LyricsMprisAppE_t>(QMC::MetaObjectFlag{}, qt_stringData,
            qt_methods, qt_properties, qt_enums);
}
Q_CONSTINIT const QMetaObject lyricsmpris::LyricsMprisApp::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_staticMetaObjectStaticContent<qt_meta_tag_ZN11lyricsmpris14LyricsMprisAppE_t>.stringdata,
    qt_staticMetaObjectStaticContent<qt_meta_tag_ZN11lyricsmpris14LyricsMprisAppE_t>.data,
    qt_static_metacall,
    nullptr,
    qt_staticMetaObjectRelocatingContent<qt_meta_tag_ZN11lyricsmpris14LyricsMprisAppE_t>.metaTypes,
    nullptr
} };

void lyricsmpris::LyricsMprisApp::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    auto *_t = static_cast<LyricsMprisApp *>(_o);
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: _t->start(); break;
        case 1: _t->refreshPlayers(); break;
        case 2: _t->handleNameOwnerChanged((*reinterpret_cast<std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast<std::add_pointer_t<QString>>(_a[2])),(*reinterpret_cast<std::add_pointer_t<QString>>(_a[3]))); break;
        case 3: _t->handlePropertiesChanged((*reinterpret_cast<std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast<std::add_pointer_t<QVariantMap>>(_a[2])),(*reinterpret_cast<std::add_pointer_t<QStringList>>(_a[3]))); break;
        case 4: _t->handleSeeked((*reinterpret_cast<std::add_pointer_t<qlonglong>>(_a[1]))); break;
        case 5: _t->updatePosition(); break;
        case 6: _t->startFallbackProviders(); break;
        case 7: _t->handleNetworkFinished(); break;
        default: ;
        }
    }
}

const QMetaObject *lyricsmpris::LyricsMprisApp::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *lyricsmpris::LyricsMprisApp::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_staticMetaObjectStaticContent<qt_meta_tag_ZN11lyricsmpris14LyricsMprisAppE_t>.strings))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int lyricsmpris::LyricsMprisApp::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 8)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 8;
    }
    if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 8)
            *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType();
        _id -= 8;
    }
    return _id;
}
QT_WARNING_POP

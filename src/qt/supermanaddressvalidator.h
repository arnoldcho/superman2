// Copyright (c) 2011-2014 The Superman Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#ifndef SUPERMAN_QT_SUPERMANADDRESSVALIDATOR_H
#define SUPERMAN_QT_SUPERMANADDRESSVALIDATOR_H

#include <QValidator>

/** Base58 entry widget validator, checks for valid characters and
 * removes some whitespace.
 */
class SupermanAddressEntryValidator : public QValidator
{
    Q_OBJECT

public:
    explicit SupermanAddressEntryValidator(QObject *parent);

    State validate(QString &input, int &pos) const override;
};

/** Superman address widget validator, checks for a valid superman address.
 */
class SupermanAddressCheckValidator : public QValidator
{
    Q_OBJECT

public:
    explicit SupermanAddressCheckValidator(QObject *parent);

    State validate(QString &input, int &pos) const override;
};

#endif // SUPERMAN_QT_SUPERMANADDRESSVALIDATOR_H

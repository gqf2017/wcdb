/*
 * Tencent is pleased to support the open source community by making
 * WCDB available.
 *
 * Copyright (C) 2017 THL A29 Limited, a Tencent company.
 * All rights reserved.
 *
 * Licensed under the BSD 3-Clause License (the "License"); you may not use
 * this file except in compliance with the License. You may obtain a copy of
 * the License at
 *
 *       https://opensource.org/licenses/BSD-3-Clause
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#ifndef Time_hpp
#define Time_hpp

#include <WCDB/SharedThreadedErrorProne.hpp>
#include <string>

namespace WCDB {

class Time : public SharedThreadedErrorProne {
public:
    Time();
    Time(long sec, long nsec);

    long sec() const;
    long nsec() const;

    bool operator>(const Time &operand) const;
    bool operator<(const Time &operand) const;
    bool operator==(const Time &operand) const;
    bool operator!=(const Time &operand) const;

    bool now();
    bool empty() const;

    std::pair<bool, std::string> stringify() const;

protected:
    long m_sec;
    long m_nsec;
};

} //namespace WCDB

#endif /* Time_hpp */

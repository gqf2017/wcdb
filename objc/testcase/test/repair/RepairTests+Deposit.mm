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

#import "RepairTestCase.h"

@interface RepairTests_Deposit : RepairTestCase

@end

@implementation RepairTests_Deposit

- (void)test_renew
{
    NSArray<WCTSequence *> *sequences = [_database getObjectsOfClass:WCTSequence.class fromTable:WCTSequence.tableName orderBy:WCTSequence.name];
    XCTAssertGreaterThan(sequences.count, 0);
    for (WCTSequence *sequence in sequences) {
        XCTAssertGreaterThan(sequence.seq, 0);
    }

    XCTAssertTrue([_database deposit]);

    WCTError *error;
    XCTAssertFalse([_database tableExists:_tableName1 withError:&error]);
    XCTAssertNil(error);
    XCTAssertFalse([_database tableExists:_tableName2 withError:&error]);
    XCTAssertNil(error);

    NSArray<WCTSequence *> *sequencesAfterDeposited = [_database getObjectsOfClass:WCTSequence.class fromTable:WCTSequence.tableName orderBy:WCTSequence.name];
    XCTAssertEqual(sequencesAfterDeposited.count, sequences.count);
    XCTAssertTrue([sequences isEqualToObjects:sequencesAfterDeposited
                               withComparator:^BOOL(WCTSequence *lhs, WCTSequence *rhs) {
                                 return lhs.seq == rhs.seq;
                               }]);
}

@end

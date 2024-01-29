package demo

import grails.testing.gorm.DomainUnitTest
import spock.lang.Specification

class GoodsSpec extends Specification implements DomainUnitTest<Goods> {

    def setup() {
    }

    def cleanup() {
    }

    void "test something"() {
        expect:"fix me"
            true == false
    }
}
